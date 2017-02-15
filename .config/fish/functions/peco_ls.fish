function peco_ls
    ls -F | peco | read line
    if test -d $line
        builtin cd $line
    else
        vim $line
    end
end
