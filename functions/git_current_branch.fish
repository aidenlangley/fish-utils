function git_current_branch --description 'Detect name of current branch of current git repository'
    echo (git branch --show-current)
end
