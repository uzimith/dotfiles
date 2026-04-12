function peco_select_branch
    git branch --all --format='%(refname:short)' | peco $peco_flags | read branch
    and wt switch -x \'tmux new -d -s {{ branch | sanitize }} $branch
end
