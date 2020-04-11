#!/usr/bin/env bash
if cat /proc/version | grep Microsoft >/dev/null 2>&1; then
     # ------ Windows 10 aliases ------------------------------------------------

    alias doc='cd /mnt/c/Users/Brendon*/Documents/Documents/'
    alias sem='doc;  cd 00*/0*/0*/; ls'
    alias dow='cd /mnt/c/Users/Brendon*/Downloads/; ls'
    alias song='dow;  cd W*/Av*/; ls -A'

elif [ "$HOME" = "/home/brendon" ]; then
# ------ Manjaro Aliases ---------------------------------------------------


# ------ Common directory navigation ---------------------------------------
    alias dow='cd ~/Downloads; lsd --group-dirs first'
    alias submit='cd ~/Documents/Mcgill/submissions; lsd --group-dirs first'
    alias sem='cd ~/Documents/Mcgill/5th-year/Winter; lsd --group-dirs first'
    alias scrot='cd ~/Pictures/Screenshots; lsd --group-dirs first; ranger'


# ------ Course directories ------------------------------------------------
    alias andor='cd /home/brendon/Documents/Mcgill/5th-year/fall-sem/andor/f2019-hexanome-14/hexanome-14/Assets; lsd --group-dirs first'
    alias cam='cd ~/Documents/Mcgill/5th-year/Winter/Compilers/Ocaml; lsd --group-dirs first'
    alias comp='cd /home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/2020_group11; lsd --group-dirs first'
    alias conc='cd /home/brendon/Downloads/programs/eclipse-workspace/ConcurrA3/src/ConcurrA3; lsd --group-dirs first'
    alias db='cd /home/brendon/Documents/Mcgill/5th-year/Winter/databases; lsd --group-dirs first'


# ------ Commands ----------------------------------------------------------
    alias utop='eval $(opam env); utop'
    # functions in betterBash -- fuzzy finds packages in pacman/yay
    alias spac='search_packages pacman'
    alias syay='search_packages yay'

    # copy speakers code to clipboards and start bluetoothctl
    alias blue='echo 'C0:28:8D:01:4F:DE' | xclip -selection c; bluetoothctl'
    alias night='redshift -l 45.513860:-73.570660'
    alias hdmi='xrandr --output HDMI1 --mode 1920x1080 --rate 60'
    # show how to run mvn from command line
    alias mrun='echo -e "mvn exec:java -Dexec.mainClass=Comp409_A1.Idk \n\t .mainClass=groupid.(class Name with Main)"'
    # monitor
    alias mon='mons -e right'
    # For multiple monitors consider changing to below, which works for 1 monitor
    # xrandr --output $( xrandr | grep 'HDMI.* connected' | head -n1 | awk '{ print $1 }' ) --off
    alias monoff='xrandr --output HDMI-0 --off'
    alias gotop='gotop -p'

    # fuzzy search and cd, files based on recency as per fasd
    alias z=fuzzy_z

    alias bashrc='source ~/.bashrc'
    # word count of current directory
    alias wcd='wc -l `find . -maxdepth 1 -type f`'

# ------ compiler tests ----------------------------------------------------
    alias arr='./main.native symbol ../programs-solution/1-scan+parse/valid/7-3-arrays.go'
    alias slice='./main.native symbol ../programs-solution/1-scan+parse/valid/7-2-slices.go'
    alias struct='./main.native symbol ../programs-solution/1-scan+parse/valid/7-4-structs.go'
    alias built='./main.native symbol ../programs-solution/1-scan+parse/valid/9-7-builtins.go'
    alias cast='./main.native symbol ../programs-solution/1-scan+parse/valid/9-8-typecastexpr.go'
    alias func='./main.native symbol ../programs-solution/1-scan+parse/valid/9-6-funccallexprs.go'

    alias parr='./main.native pretty ../programs-solution/1-scan+parse/valid/7-3-arrays.go'
    alias pslice='./main.native pretty ../programs-solution/1-scan+parse/valid/7-2-slices.go'
    alias pstruct='./main.native pretty ../programs-solution/1-scan+parse/valid/7-4-structs.go'
    alias pbuilt='./main.native pretty ../programs-solution/1-scan+parse/valid/9-7-builtins.go'
    alias pcast='./main.native pretty ../programs-solution/1-scan+parse/valid/9-8-typecastexpr.go'
    alias pfunc='./main.native pretty ../programs-solution/1-scan+parse/valid/9-6-funccallexprs.go'

    alias sym='bash /home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/testprogs/symTest.sh'
    alias pretty='bash /home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/testprogs/prettyTest.sh'



# ------ Random directories ------------------------------------------------
    # mnemonic:  EclipseWorkspace
    alias ework='cd /home/brendon/Downloads/programs/eclipse-workspace; lsd --group-dirs first'
    alias print='cd ~/Scripts/my_projects/print; lsd --group-dirs first'

    alias eclipse='cd /home/brendon/Downloads/programs/java-2019-06/eclipse; ./eclipse &'


fi
# ------ END OS SPECIFIC ALIASES -------------------------------------------



# -------------- NAVIGATION ------------------------------------------------
alias   .='ls'
alias  ..='cd ..;  ls'
alias ...='up 2;  ls'
if [ -d ~/dotfiles/bashh ]; then
    alias dotf='cd ~/dotfiles/bashh; lsa'
    alias cdl=changeDirAndShow
    alias cdl..='cdl ..'
fi

# ls
alias ls='lsd --group-dirs first'
alias lsa='ls -A'
# ls -l --total-size --blocks user,size,name
alias ll='ls -l --total-size'
# show file sizes
alias lss='ls -l --blocks size,name'


# -------------- CONDA -----------------------------------------------------
if hash conda > /dev/null 2>&1; then
    alias newc='conda create -n'
    alias remc='conda env remove --name'
    alias act='conda activate'
    alias deac='conda deactivate'
fi


# -------------- GITHUB ----------------------------------------------------
if hash git > /dev/null 2>&1; then
    alias gcom='git commit -m'
    alias co='git checkout'
    alias gadd='git add'

    alias gstat='git status -s'
    alias gl1='git log --oneline'

    # mnemonic: Git Branch Delete
    # alias gbd='
    alias gbd=fuzzyDeleteBranch

elif [ "$HOME" = "/home/brendon" ]; then
    echo "git not found, no aliases created."
fi

# -------------- Configuration Version Control -----------------------------
#https://www.atlassian.com/git/tutorials/dotfiles

# don't add this to servers
if [ "$HOME" = "/home/brendon" ]; then
    alias config='/usr/bin/git --git-dir=/home/brendon/.cfg/ --work-tree=/home/brendon'

    alias cadd='config add ~/dotfiles/bashh/configAdd.sh; source ~/dotfiles/bashh/configAdd.sh'
    alias ccom='config commit -m'
    alias cpush='config push origin master'
fi

# -------------- APPLICATIONS ----------------------------------------------
alias bell='echo -ne "\a"'
if hash bat > /dev/null 2>&1; then
    alias cat='bat'
elif [ "$HOME" = "/home/brendon" ]; then
    echo "bat not found, alias not created."
fi

if hash pinfo > /dev/null 2>&1; then
    alias man='pinfo'
elif [ "$HOME" = "/home/brendon" ]; then
    echo "pinfo not found, alias not created."
fi

if hash xdg-open > /dev/null 2>&1; then
    # setsid opens the file in a new session so the process will survive the parent process.
    alias open='setsid xdg-open'
elif [ "$HOME" = "/home/brendon" ]; then
    echo "xdg-open not found, alias not created."
fi

alias vim="$VISUAL"
alias vi="$VISUAL"
alias rpy='python3'


# -------------- CORRECT TYPOS ---------------------------------------------
alias cd..='cd ..'
alias cd-='cd -'

# mnemonic: add sudo
alias as='sudo $(history -p !!)'


# -------------- RANDOM ----------------------------------------------------
# The trailing space tells shell to look for aliases in other that first word of cmd
alias sudo='sudo '

# An "alert" alias for long running commands.
# sends notification containing the command the command when it's done
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'




# -------------- Previous class directories --------------------------------

# save these in case I want to find them again.


    #alias graph='cd /home/brendon/Downloads/1-Classes/graphics/COMP557A4F19Provided/comp557F19/src/comp557/a4; ls'

    # alias graph='cd ~/Downloads/Assignments/COMP557A3F19Provided/comp557F19/src/comp557/a3; ls; echo -e "\n  ----------------------------   up 3 to root dir"'

    #alias toclip='cd /home/brendon/Downloads/programs/eclipse-workspace/graphics-a2/src/comp557/a2; ls'
