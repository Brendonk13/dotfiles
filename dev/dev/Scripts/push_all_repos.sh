#!/usr/bin/env bash

pushCurrentBranch(){
    local current_branch
    current_branch="$(git branch -a | awk '{if ($1 ~ /\*/) print $NF}')"
    git push origin "$current_branch"
}


repos=("$HOME/dev/dev/langs/PyStuff" "$HOME/dev/notes/Notes/Linux" "$HOME/dev/notes/Notes/Hardware")

for repo in "${repos[@]}"; do
    [ -d "$repo" ] && cd "$repo"
    git_st_lines="$(git st | wc -l)"
    [ "$git_st_lines" = 1 ] && echo -e "Skipping unmodified $repo\n" && continue

    echo "$repo" && git st
    echo 'Enter:  (y/n/p) for git add, or git add patch'
    read git_add
    if [ "$git_add" = 'y' ]; then
        git a
    elif [ "$git_add" = 'p' ]; then
        # Improvement: when patching, loop again with same repo
        git a -p
    else
        continue
    fi
    echo 'Please enter the commit message'
    read commit_msg
    git com -m "$commit_msg" && pushCurrentBranch
    echo -e '================================================================================\n'
done
