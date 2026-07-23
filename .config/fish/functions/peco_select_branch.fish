function peco_select_branch
    git branch --all --format='%(refname:short)' | peco $peco_flags | read branch
    and wt switch --no-cd -x 'herdr workspace create --cwd {{ worktree_path }} --label {{ branch | sanitize }} --focus' $branch
end
