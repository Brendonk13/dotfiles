#!/usr/bin/env bash

# -------------- GITHUB --------------------------------------------------------
if hash git > /dev/null 2>&1; then
    alias g='git'
    # alias gcom='git commit -m'
else
    echo "git not found, no alias (g=git) created."
fi

