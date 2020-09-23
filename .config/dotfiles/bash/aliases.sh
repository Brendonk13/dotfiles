#!/usr/bin/env bash

# change this OS check to one found in .bash_profile (once tested that it works on win10)
# because: macOS (boooo) doesn't have /proc
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
    alias cam='cd ~/Documents/Mcgill/5th-year/Winter/Compilers/Ocaml; lsd --group-dirs first'
    alias 326='cd "$sem";  cd 326;             lsd --group-dirs first'
    alias 321='cd "$sem";  cd Prog_challenges; lsd --group-dirs first'
    alias 429='cd "$sem";  cd 429;             lsd --group-dirs first'
    alias chem='cd "$sem"; cd Chem;            lsd --group-dirs first'
    alias atmo='cd "$sem"; cd Atmosphere;      lsd --group-dirs first'


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

    alias top='ytop -p -c monokai'

    # monitors
    # alias mon='mons -e right'
    alias mon='mons -e left'
    # ^--> my screen on left
    # For multiple monitors consider changing to below, which works for 1 monitor
    # xrandr --output $( xrandr | grep 'HDMI.* connected' | head -n1 | awk '{ print $1 }' ) --off
    alias monoff='xrandr --output HDMI-0 --off'

    #Note: can view nvidia gpu live shit with: $ nvtop

    alias bashrc='source ~/.bashrc'


    # ------ My bash fxns ------------------------------------------------------

    # fuzzy search and cd, files based on recency as per fasd
    alias z=fuzzy_z

    # fuzzy search thru pacman -Slq then download package
    alias spac='search_packages pacman'
    # same for AUR
    alias syay='search_packages yay'

    # word count of current directory
    alias lines=lines_in_dir
    # alias wcd='wc -l `find . -maxdepth 1 -type f`'
    # add this as a bash function later where I can send the filetype as an argument
    # word count of a given filetype in a directory
    # alias wcf='wcd | awk '$NF ~ /.sh$/{print $1 " " $NF}''

    # this sums the line count and prints it at the end
    # alias wcf='wcd | awk '$NF ~ /.sh$/{SUM+=$1; print $1 " " $NF}END{print SUM}''



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
if [ -d  "$XDG_CONFIG_HOME"/dotfiles/bash ]; then
    alias dotf='cd "$XDG_CONFIG_HOME"/dotfiles/bash; lsa'
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
    alias ls='ls --group-directories --color=always'
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
    alias g='git'
    alias gcom='git commit -m'
    # alias gadd='git add'

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

if [ "$HOME" = "/home/brendon" ] || [ "$HOME" = "/Users/macadmin" ]; then
    # don't add this to servers

    alias config='/usr/bin/git --git-dir="$HOME"/.cfg/ --work-tree="$HOME"'
    alias cadd='config add "$XDG_CONFIG_HOME"/dotfiles/bash/configAdd.sh; source  "$XDG_CONFIG_HOME"/dotfiles/bash/configAdd.sh'
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
# mnemonic: Run Python
alias rpy='python3'


# -------------- CORRECT TYPOS -------------------------------------------------
alias cd..='cd ..'
alias cd-='cd -'

# mnemonic: Add Sudo
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
