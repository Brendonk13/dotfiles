#!/bin/bash
#alias doc='cd /mnt/c/Users/Brendon*/Documents/Documents/'
#alias sem='doc;  cd 00*/0*/0*/'
#alias dow='cd /mnt/c/Users/Brendon*/Downloads/'
#alias song='dow;  cd W*/Av*/'

#alias do

#need to make alias ls='lsd' but first need to configure terminal colorscheme

alias cd..='cd ..'
alias   .='ls'
alias  ..='cd ..;  ls'
alias ...='up 2;  ls'

alias rpy='python3'

alias newc='conda create -n'
alias remc='conda env remove --name'   
alias act='conda activate'
alias deac='conda deactivate'

# maybe I want to add in --hidden, .. later
alias ag='ag --path-to-ignore ~/.ignore'

alias vi="$VISUAL"
alias v="$VISUAL"

#alias s!='sudo "!!"'

# mnemonic: add sudo
alias as='sudo $(history -p !!)'

alias cadd='config add ~/.bashrc; config add ~/.vimrc; config add ~/dotfiles/'


# note that can make sudo work with aliases by adding: 
# alias sudo='sudo ' -- the trailing space tells shell to look for aliases in other that first word of cmd

# need to actually add files to bare dotfile repo
# just add and commit files one at a time ie config add .vimr, config com.. config push finally

alias pip='pip3'
alias vim="$VISUAL"
# this is a function defined in .betterBash
alias cdl=changeDirAndShow
alias cdl..='cdl ..'
#alias lcc..='lcc ..'
# -A doesn't show ., .. directories while -a does
alias lsa='ls -A'
alias ll='ls -l'
alias dotf='cd ~/dotfiles/bashh; lsa'
alias ag='ag --ignore-dir ~/FromInternet'
alias gcom='git commit -m'

alias cat='bat'
alias bell='echo -ne "\a"'

# functions in betterBash -- fuzzy finds packages in pacman/yay
alias spac='search_packages pacman'
alias syay='search_packages yay'

alias blue='echo 'C0:28:8D:01:4F:DE' | xclip -selection c; bluetoothctl'
