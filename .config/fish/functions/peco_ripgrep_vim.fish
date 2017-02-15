function peco_ripgrep_vim
    set __query ""
    if test (count $argv) -ge 1
        set __query $argv
    else
        vared __query
    end
    rg -n $__query | peco | awk -F : '{print "-c " $2 " " $1}' | xargs nvim
end
