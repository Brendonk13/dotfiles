#!/bin/bash
if cat /proc/version | grep Microsoft >/dev/null 2>&1; then

    alias doc='cd /mnt/c/Users/Brendon*/Documents/Documents/'
    alias sem='doc;  cd 00*/0*/0*/'
    alias dow='cd /mnt/c/Users/Brendon*/Downloads/'
    alias song='dow;  cd W*/Av*/'

else
    alias dow='cd ~/Downloads'
    alias submit='cd ~/Documents/Mcgill/submissions'
    alias sem='cd ~/Documents/Mcgill/5th-year'

    # functions in betterBash -- fuzzy finds packages in pacman/yay
    alias spac='search_packages pacman'
    alias syay='search_packages yay'

    # copy speakers code to clipboards
    alias blue='echo 'C0:28:8D:01:4F:DE' | xclip -selection c; bluetoothctl'

    alias eclipse='cd /home/brendonk/Downloads/programs/java-2019-06/eclipse; ./eclipse &'
    alias eclipsedir='cd /home/brendonk/Downloads/programs/eclipse-workspace/graphics-a1/src/comp557/a1; ls'

fi

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
alias cpush='config push origin master'
alias ccom='config commit -m'

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

alias co='git checkout'
alias gadd='git add'
alias gstat='git status'
alias gl1='git log --oneline'

alias cat='bat'
alias bell='echo -ne "\a"'
alias man='pinfo'
alias open='xdg-open'
alias sudo='sudo '


