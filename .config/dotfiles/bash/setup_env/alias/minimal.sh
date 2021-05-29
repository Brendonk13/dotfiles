#!/usr/bin/env bash


alias ls='ls --group-directories --color=always'
alias lsa='ls -A'
# ls -l --total-size --blocks user,size,name
alias ll='ls -l --size'
# show file sizes

if [ -d "$bash_dotfiles_root" ]; then
    alias dotf='cd "$bash_dotfiles_root"; lsa'
fi


alias bashrc='source ~/.bashrc'


alias   .='ls'
alias  ..='cd ..;  ls'
alias ...='cd ../..;  ls'


if hash tree > /dev/null 2>&1; then
    alias tree='tree -F --dirsfirst -C'
else
    echo 'tree command not found, alias not created'
fi


find_logs(){
    # Search lsof for a process's open files, return results containing string: 'log'
    # returns some bad results but thats 1 out of 5 results for systemd, less for smaller programs!
    [ $# -ne 1 ] && echo -e "USAGE: find_logs program_name\nError: Need program_name arg, and only this arg" && return 1
    local program_name="$1"
    [ hash rg > /dev/null 2&>1 ] && grep_prg='rg' || grep_prg='grep'
    local log_files
    log_files="$(pgrep "$program_name" | sudo xargs -n1 lsof -p 2> /dev/null | $grep_prg log | awk '{print $NF}' | $grep_prg log)"
    if [ -n "$log_files" ]; then
        echo "$log_files"
        return 0
    else
        echo "No log files found for program: $program_name with pid: $(pgrep "$program_name")"
        return 1
    fi
}
alias flog='find_logs'


# spelling mistakes
alias cd..='cd ..'
alias cd-='cd -'

alias mkdri='mkdir'
alias mdkir='mkdir'
