#!/usr/bin/env bash

# source ../debug/common/debug_dependencies.sh

# if  hash ps > /dev/null 2>&1 && hash sort /dev/null 2>&1 && hash head /dev/null 2>&1; then
if have_dependencies 'ps' 'sort' 'head'; then
    # show top 5 pid's according to cpu usage
    alias badproc='ps aux | sort -rk 3,3 | head -n 5'
fi

find_logs(){
    # Search lsof for a process's open files, return results containing string: 'log'
    # returns some bad results but thats 1 out of 5 results for systemd, less for smaller programs!
    [ $# -ne 1 ] && echo -e "USAGE: find_logs program_name\nError: Need program_name arg, and only this arg" && return 1
    program_name="$1"
    pgrep "$program_name" | sudo xargs -n1 lsof -p 2> /dev/null | grep log | awk '{print $NF}' | grep log
}
alias flog='find_logs'

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
