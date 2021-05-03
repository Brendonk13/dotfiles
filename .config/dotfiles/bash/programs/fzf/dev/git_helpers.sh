#!/usr/bin/env bash

if ! have_dependencies 'fzf' 'awk' 'git' 'xargs' 'cut'; then
    echo "Exiting with no functions sourced, fzf not found in: $0"
    exit 1
fi


# search through all branches and merge entered selection
fuzzyMerge() {
    # search for all merge conflicts upon merge, display conflicts if there are any
    git branch -a | fzf | awk '{print $NF}' | xargs git merge || git mergetool #showMergeConflicts
}
alias merg=fuzzyMerge


# search through all branches and check it out
fuzzySwitchBranch() {
    git branch -a | fzf | awk '{print $NF}' | xargs git checkout
}
alias co=fuzzySwitchBranch


fuzzyDeleteBranch() {
    # last column is the name we are looking for
    local chosen_branch
    chosen_branch="$(git branch -a | fzf | awk '{print $NF}')"
    [[ "$chosen_branch" = "" ]] && return

    local just_name
    if [[ "$chosen_branch" = remotes* ]]; then
        # delimited by /  only keep 3rd field of remotes/origin/branch_name
        just_name="$(echo "$chosen_branch" | cut -d '/' -f3)"
    else
        just_name="$chosen_branch"
    fi
    # delete the local branch
    git branch -D "$just_name"
    # delete remote branch
    [[ "$chosen_branch" = remotes* ]] && git push origin --delete "$just_name"
}
alias gbd=fuzzyDeleteBranch

