#include <mach/mach.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/sysctl.h>

int main(int argc, char *argv[]) {
  if (argc != 2) return 1;

  natural_t count;
  processor_info_array_t info;
  mach_msg_type_number_t info_count;
  if (host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &count,
                          &info, &info_count) != KERN_SUCCESS) {
    return 1;
  }

  unsigned long long *previous_total = calloc(count, sizeof(*previous_total));
  unsigned long long *previous_idle = calloc(count, sizeof(*previous_idle));
  unsigned int previous_count = 0;
  FILE *state = fopen(argv[1], "r");
  if (state) {
    fscanf(state, "%u", &previous_count);
    for (natural_t i = 0; i < count; i++) {
      if (fscanf(state, "%llu %llu", &previous_total[i], &previous_idle[i]) != 2) {
        previous_count = 0;
        break;
      }
    }
    fclose(state);
  }

  state = fopen(argv[1], "w");
  if (!state) return 1;
  fprintf(state, "%u\n", count);

  unsigned int performance_count = 0;
  size_t performance_count_size = sizeof(performance_count);
  if (sysctlbyname("hw.perflevel0.logicalcpu", &performance_count,
                  &performance_count_size, NULL, 0) != 0 ||
      performance_count == 0 || performance_count >= count) {
    performance_count = count;
  }
  unsigned long long performance_total = 0, performance_active = 0;
  unsigned long long efficiency_total = 0, efficiency_active = 0;
  processor_cpu_load_info_t loads = (processor_cpu_load_info_t)info;
  for (natural_t i = 0; i < count; i++) {
    unsigned long long user = loads[i].cpu_ticks[CPU_STATE_USER];
    unsigned long long system = loads[i].cpu_ticks[CPU_STATE_SYSTEM];
    unsigned long long nice = loads[i].cpu_ticks[CPU_STATE_NICE];
    unsigned long long idle = loads[i].cpu_ticks[CPU_STATE_IDLE];
    unsigned long long total = user + system + nice + idle;
    fprintf(state, "%llu %llu\n", total, idle);

    if (previous_count == count && total > previous_total[i]) {
      unsigned long long delta_total = total - previous_total[i];
      unsigned long long delta_idle = idle - previous_idle[i];
      if (i < performance_count) {
        performance_total += delta_total;
        performance_active += delta_total - delta_idle;
      } else {
        efficiency_total += delta_total;
        efficiency_active += delta_total - delta_idle;
      }
    }
  }
  fclose(state);

  if (previous_count != count || performance_total == 0) {
    printf("--/--");
  } else if (efficiency_total == 0) {
    printf("%llu%%/--", 100 * performance_active / performance_total);
  } else {
    printf("%llu%%/%llu%%", 100 * performance_active / performance_total,
           100 * efficiency_active / efficiency_total);
  }

  vm_deallocate(mach_task_self(), (vm_address_t)info,
                info_count * sizeof(integer_t));
  free(previous_total);
  free(previous_idle);
  return 0;
}
