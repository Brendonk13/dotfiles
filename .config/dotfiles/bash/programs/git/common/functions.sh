#!/usr/bin/env bash

# this will just push to origin current_branch
pushCurrentBranch() {
    # extract name of current branch from output, here first column is *
    local current_branch
    current_branch="$(git branch -a | awk '{if ($1 ~ /\*/) print $NF}')"
    git push origin "$current_branch"
}
alias gpush=pushCurrentBranch


# pull from current branch
pullCurrentBranch() {
    local current_branch
    current_branch="$(git branch -a | awk '{if ($1 ~ /\*/) print $NF}')"
    git pull origin "$current_branch"
}
alias gpull=pullCurrentBranch

