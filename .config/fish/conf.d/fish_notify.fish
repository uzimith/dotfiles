function fish_notify --on-event fish_prompt
    set _display_status $status
    if test $CMD_DURATION
        set secs (math "$CMD_DURATION / 1000")
        if test $secs -ge 30
            switch (uname)
                case Linux
                    # WSL
                    /mnt/c/SnoreToast.exe -t $history[1] -m "Returned $_display_status, took $secs seconds" -silent -w -id SnoreToast >/dev/null &
                case Darwin
                    terminal-notifier -title $history[1] -message ""
            end
        end
    end
end
