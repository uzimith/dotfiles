function peco_select_branch
    git branch --all --format='%(refname:short)' | peco $peco_flags | read branch
    and wt switch -x 'herdr tab create --cwd {{ worktree_path }} --label {{ branch | sanitize }} --no-focus' $branch
end
