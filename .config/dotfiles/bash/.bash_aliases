#!/usr/bin/env bash
if cat /proc/version | grep Microsoft >/dev/null 2>&1; then
# ------ Windows 10 aliases ----------------------------------------------------

    alias doc='cd /mnt/c/Users/Brendon*/Documents/Documents/'
    alias sem='doc;  cd 00*/0*/0*/; ls'
    alias dow='cd /mnt/c/Users/Brendon*/Downloads/; ls'
    alias song='dow;  cd W*/Av*/; ls -A'

elif [ "$HOME" = "/home/brendon" ]; then
# ------ Manjaro Aliases -------------------------------------------------------


    # ------ Common directory navigation ---------------------------------------
    alias dow='cd "$dow"; lsd --group-dirs first'
    alias submit='cd "$submit"; lsd --group-dirs first'
    alias sem='cd "$sem"; lsd --group-dirs first'
    alias scrot='cd ~/Pictures/Screenshots; lsd --group-dirs first; ranger'


    # ------ Course directories ------------------------------------------------
    alias andor='cd "$andor"; lsd --group-dirs first'
    alias cam='cd ~/Documents/Mcgill/5th-year/Winter/Compilers/Ocaml; lsd --group-dirs first'
    alias comp='cd "$comp"; lsd --group-dirs first'
    alias conc='cd /home/brendon/Downloads/programs/eclipse-workspace/ConcurrA3/src/ConcurrA3; lsd --group-dirs first'
    alias db='cd /home/brendon/Documents/Mcgill/5th-year/Winter/databases; lsd --group-dirs first'
    alias peep='cd "$comp"; cd ../../Peephole-Template; lsd --group-dirs first'



    # ------ Commands ----------------------------------------------------------
    alias utop='eval $(opam env); utop'
    # functions in betterBash -- fuzzy finds packages in pacman/yay

    # show top 5 pid's according to cpu usage
    alias badproc='ps aux | sort -rk 3,3 | head -n 5'

    # python linter, only checks syntax errors
    alias plint='pyflakes'

    # copy speakers code to clipboards and start bluetoothctl
    alias blue='echo 'C0:28:8D:01:4F:DE' | xclip -selection c; bluetoothctl'
    alias hdmi='xrandr --output HDMI1 --mode 1920x1080 --rate 60'
    # show how to run mvn from command line
    alias mrun='echo -e "mvn exec:java -Dexec.mainClass=Comp409_A1.Idk \n\t .mainClass=groupid.(class Name with Main)"'
    # monitor
    alias mon='mons -e right'
    # For multiple monitors consider changing to below, which works for 1 monitor
    # xrandr --output $( xrandr | grep 'HDMI.* connected' | head -n1 | awk '{ print $1 }' ) --off
    alias monoff='xrandr --output HDMI-0 --off'
    alias gotop='gotop -p'

    alias bashrc='source ~/.bashrc'

    alias pat='cp /home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/Peephole-Template/JOOSA-src/patterns.h /home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/'
    alias mpat='mv /home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/patterns.h /home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/Peephole-Template/JOOSA-src/'

    # word count of current directory
    alias wcd='wc -l `find . -maxdepth 1 -type f`'
    # add this as a bash function later where I can send the filetype as an argument
    # word count of a given filetype in a directory
    # alias wcf='wcd | awk '$NF ~ /.sh$/{print $1 " " $NF}''

    # this sums the line count and prints it at the end
    # alias wcf='wcd | awk '$NF ~ /.sh$/{SUM+=$1; print $1 " " $NF}END{print SUM}''


    # ------ My bash fxns ------------------------------------------------------

    # fuzzy search and cd, files based on recency as per fasd
    alias z=fuzzy_z

    # fuzzy search thru pacman -Slq then download package
    alias spac='search_packages pacman'
    # same for AUR
    alias syay='search_packages yay'

    # ------ compiler tests ----------------------------------------------------
    source "$comp/../test-mode.sh"



    # ------ Random directories ------------------------------------------------
    # mnemonic:  EclipseWorkspace
    alias ework='cd /home/brendon/Downloads/programs/eclipse-workspace; lsd --group-dirs first'
    alias print='cd ~/Scripts/my_projects/print; lsd --group-dirs first'

    alias eclipse='cd /home/brendon/Downloads/programs/java-2019-06/eclipse; ./eclipse &'


fi
# ------ END OS SPECIFIC ALIASES -----------------------------------------------



# -------------- NAVIGATION ----------------------------------------------------
alias   .='ls'
alias  ..='cd ..;  ls'
alias ...='up 2;  ls'
if [ -d ~/.config/dotfiles/bash ]; then
    alias dotf='cd ~/.config/dotfiles/bash; lsa'
    alias cdl=changeDirAndShow
    alias cdl..='cdl ..'
fi


# -------------- LS ------------------------------------------------------------
if hash lsd > /dev/null 2>&1; then
    alias ls='lsd --group-dirs first'
    alias lsa='ls -A'
    # ls -l --total-size --blocks user,size,name
    alias ll='ls -l --total-size'
    # show file sizes
    alias lss='ls -l --blocks size,name'
else
    alias ls='ls --group-directories --color'
    alias lsa='ls -A'
    # ls -l --total-size --blocks user,size,name
    alias ll='ls -l --size'
    # show file sizes
fi

alias tree='tree -F --dirsfirst -C'

# -------------- CONDA ---------------------------------------------------------
if hash conda > /dev/null 2>&1; then
    alias newc='conda create -n'
    alias remc='conda env remove --name'
    alias act='conda activate'
    alias deac='conda deactivate'
fi


# -------------- GITHUB --------------------------------------------------------
if hash git > /dev/null 2>&1; then
    alias gcom='git commit -m'
    alias gadd='git add'

    alias gstat='git status -s'
    # show graph and also branches/tags which reference the commit.
    alias gl1='git log --oneline --graph --decorate'
    alias conflict=showMergeConflicts

    alias gpush=pushCurrentBranch
    alias gpull=pullCurrentBranch

    # mnemonic: Git Branch Delete
    alias gbd=fuzzyDeleteBranch
    alias co=fuzzySwitchBranch

    alias merg=fuzzyMerge

elif [ "$HOME" = "/home/brendon" ]; then
    # just for clean installs
    echo "git not found, no aliases created."
fi

#------------------ DOTFILES REPO ----------------------------------------------
#https://www.atlassian.com/git/tutorials/dotfiles

if [ "$HOME" = "/home/brendon" ]; then
    # don't add this to servers

    alias config='/usr/bin/git --git-dir=/home/brendon/.cfg/ --work-tree=/home/brendon'

    alias cadd='config add ~/.config/dotfiles/bash/configAdd.sh; source ~/.config/dotfiles/bash/configAdd.sh'
    alias ccom='config commit -m'
    alias cpush='config push origin master'
fi

# -------------- APPLICATIONS --------------------------------------------------
alias bell='echo -ne "\a"'
if hash bat > /dev/null 2>&1; then
    alias cat='bat'
elif [ "$HOME" = "/home/brendon" ]; then
    echo "bat not found, alias not created."
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


# -------------- CORRECT TYPOS -------------------------------------------------
alias cd..='cd ..'
alias cd-='cd -'

# mnemonic: add sudo
alias as='sudo $(history -p !!)'


# -------------- RANDOM --------------------------------------------------------
# The trailing space tells shell to look for aliases in other than first word of cmd
alias sudo='sudo '

# An "alert" alias for long running commands. ex.) pacman -Syyu; alert
# sends notification containing the command name when it's done
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'




# -------------- Previous class directories ------------------------------------

# save these in case I want to find them again.


    #alias graph='cd /home/brendon/Downloads/1-Classes/graphics/COMP557A4F19Provided/comp557F19/src/comp557/a4; ls'

    # alias graph='cd ~/Downloads/Assignments/COMP557A3F19Provided/comp557F19/src/comp557/a3; ls; echo -e "\n  ----------------------------   up 3 to root dir"'

    #alias toclip='cd /home/brendon/Downloads/programs/eclipse-workspace/graphics-a2/src/comp557/a2; ls'
