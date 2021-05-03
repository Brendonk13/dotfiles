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


# spelling mistakes
alias cd..='cd ..'
alias cd-='cd -'

alias mkdri='mkdir'
alias mdkir='mkdir'
