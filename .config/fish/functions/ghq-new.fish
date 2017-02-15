function ghq-new
    set github 1
    getopts $argv | while read -l key value
        switch $key
            case g github
                set github 1
            case no-github
                set github 0
            case p private
                set hub_args $hub_args '-p'
            case _
                if test $repository
                    echo 'The repository name is already defined.'
                    return 1
                end
                set repository $value
        end
    end
    if not test "$repository"
        echo 'A repository name is required. "ghq_new [reopsitory]"'
        return 1
    end

    set user (git config --get github.user)
    set path (ghq root)"/github.com/$user/$repository"
    if test -e $path
        echo "$repository is already exists."
        return 1
    end
    mkdir -p $path
    cd $path
    git init .
    touch README.md
    git add README.md
    git commit -m 'first commit'
    if test $github -eq 1
        hub $hub_args create
        git push -u origin master
    end
end
