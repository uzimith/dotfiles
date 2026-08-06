function tuicrpr --description 'Open the PR of the current branch in tuicr'
    set -l n (gh pr view --json number -q .number); or return 1
    tuicr pr $n
end
