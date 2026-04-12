function peco_select_branch
    git branch --all --format='%(refname:short)' | peco $peco_flags | read branch
    and git checkout $branch
end
