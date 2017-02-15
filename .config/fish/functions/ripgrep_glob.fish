function ripgrep_glob
    if test (count $argv) -ne 1
        echo "error: too many arguments"
        return 1
    end
    switch $argv
        case '*\**'
            rg --files -g $argv
        case '*'
            rg --files -g "*$argv*"
    end
end
