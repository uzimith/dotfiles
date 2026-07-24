function update_main_on_enter --on-variable PWD
    set -l repo (command git -C "$PWD" rev-parse --show-toplevel 2>/dev/null); or return

    test "$PWD" = "$repo"; or return
    test (command git -C "$repo" branch --show-current) = main; or return
    command git -C "$repo" diff --quiet; or return
    command git -C "$repo" diff --cached --quiet; or return

    command git -C "$repo" pull --ff-only >/dev/null 2>&1 &
end
