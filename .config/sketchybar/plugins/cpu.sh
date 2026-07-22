#!/bin/sh

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
helper="${TMPDIR:-/tmp}/sketchybar-cpu-cores-${UID:-$(id -u)}"
state="${TMPDIR:-/tmp}/sketchybar-cpu-cores-${UID:-$(id -u)}.state"

if [ ! -x "$helper" ] || [ "$script_dir/cpu_cores.c" -nt "$helper" ]; then
  cc -O2 -o "$helper" "$script_dir/cpu_cores.c" 2>/dev/null || exit 0
fi

cpu_usage="$("$helper" "$state")"
sketchybar --set "$NAME" label="${cpu_usage:-N/A}"
