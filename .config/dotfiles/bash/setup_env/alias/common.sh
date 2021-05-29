#!/usr/bin/env bash

# source ../debug/common/debug_dependencies.sh

# if  hash ps > /dev/null 2>&1 && hash sort /dev/null 2>&1 && hash head /dev/null 2>&1; then
if have_dependencies 'ps' 'sort' 'head'; then
    # show top 5 pid's according to cpu usage
    alias badproc='ps aux | sort -rk 3,3 | head -n 5'
fi

alias vim="$VISUAL"
alias vi="$VISUAL"


if hash python3 > /dev/null 2>&1; then
    # mnemonic: Run Python
    # alias rpy='python3'
    alias p='python3'
elif hash python > /dev/null 2>&1; then
    alias p='python'
    echo 'python3 not found, p=python2 alias set instead'
else
    echo 'no python found on this machine at all'
fi

# -------------- CORRECT TYPOS -------------------------------------------------

# mnemonic: Add Sudo
# alias as='sudo $(history -p !!)'
alias as='sudo !!'

# -------------- RANDOM --------------------------------------------------------
