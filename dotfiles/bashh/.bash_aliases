#!/bin/env bash
if cat /proc/version | grep Microsoft >/dev/null 2>&1; then

    alias doc='cd /mnt/c/Users/Brendon*/Documents/Documents/'
    alias sem='doc;  cd 00*/0*/0*/; ls'
    alias dow='cd /mnt/c/Users/Brendon*/Downloads/; ls'
    alias song='dow;  cd W*/Av*/; ls -A'

else
    alias dow='cd ~/Downloads; ls'
    alias submit='cd ~/Documents/Mcgill/submissions'
    alias sem='cd ~/Documents/Mcgill/5th-year/fall-sem; ls'
    alias scrot='cd ~/Pictures/screenshots; ls'

    # functions in betterBash -- fuzzy finds packages in pacman/yay
    alias spac='search_packages pacman'
    alias syay='search_packages yay'

    # copy speakers code to clipboards
    alias blue='echo 'C0:28:8D:01:4F:DE' | xclip -selection c; bluetoothctl'
    alias night='redshift -l 45.513860:-73.570660'

    #alias al=search_aliases
    alias graph='cd /home/brendonk/Downloads/1-Classes/graphics/COMP557A4F19Provided/comp557F19/src/comp557/a4; ls'
    # alias graph='cd ~/Downloads/Assignments/COMP557A3F19Provided/comp557F19/src/comp557/a3; ls; echo -e "\n  ----------------------------   up 3 to root dir"'
    alias eclipse='cd /home/brendonk/Downloads/programs/java-2019-06/eclipse; ./eclipse &'
    #alias toclip='cd /home/brendonk/Downloads/programs/eclipse-workspace/graphics-a2/src/comp557/a2; ls'

    # mnemonic:  EclipseWorkspace
    alias ework='cd /home/brendonk/Downloads/programs/eclipse-workspace; ls'
    alias andor='cd /home/brendonk/Documents/Mcgill/5th-year/fall-sem/andor/f2019-hexanome-14; ls'

fi


alias cd..='cd ..'
alias   .='ls'
alias  ..='cd ..;  ls'
alias ...='up 2;  ls'
alias dotf='cd ~/dotfiles/bashh; lsa'
alias cdl=changeDirAndShow
alias cdl..='cdl ..'

alias ls='ls --group-directories-first --color=auto'
alias lsa='ls -A'
alias ll='ls -l'

alias rpy='python3'
alias pip='pip3'

alias newc='conda create -n'
alias remc='conda env remove --name'   
alias act='conda activate'
alias deac='conda deactivate'

alias vim="$VISUAL"
alias vi="$VISUAL"
alias v="$VISUAL"

alias gcom='git commit -m'
alias co='git checkout'
alias gadd='git add'
alias gstat='git status'
alias gl1='git log --oneline'

alias cat='bat'
alias bell='echo -ne "\a"'
alias man='pinfo'
alias open='xdg-open'

# An "alert" alias for long running commands.
# sends notification containing the command the command when it's done
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# The trailing space tells shell to look for aliases in other that first word of cmd
alias sudo='sudo '
# mnemonic: add sudo
alias as='sudo $(history -p !!)'

#https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=/home/brendonk/.cfg/ --work-tree=/home/brendonk'

alias cadd='config add ~/.bashrc; config add ~/.vimrc; config add ~/dotfiles/; config add ~/.config/polybar'
alias cpush='config push origin master'
alias ccom='config commit -m'
