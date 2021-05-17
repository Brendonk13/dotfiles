#!/usr/bin/env bash




# ============================================================================== #
# ============================================================================== #
# ===============  setup_env/exports/desktop/PATH_extensions.sh  =============== #
# ============================================================================== #


# note that below did NOT work for changing jdk
# export JAVA_HOME="/opt/java/jdk-11.0.6"
# export PATH=$PATH:"/opt/java/jdk-11.0.6/bin"
# this works maybe should add to .bash_profile tho
# export JAVA_HOME=/opt/java/jdk-11.0.6
export PATH="/home/$USER/bin:$PATH"



# ======================================================================= #
# ======================================================================= #
# ===============  setup_env/exports/desktop/cmn_dirs.sh  =============== #
# ======================================================================= #


export dow="$HOME/Downloads/"
export submit="$HOME/Documents/Mcgill/submissions/"
export sem="$HOME/Documents/Mcgill/6th-year/"
export mors="$HOME/dev/dev/langs/PyStuff/morsels"
export ZIP="$HOME/Downloads/Random/Zips/"



# ======================================================================= #
# ======================================================================= #
# ===============  setup_env/alias/desktop/rand_progs.sh  =============== #
# ======================================================================= #


#Note: can view nvidia gpu live shit with: $ nvtop


if hash xdg-open > /dev/null 2>&1; then
    # setsid opens the file in a new session so the process will survive the parent process.
    alias open='setsid xdg-open'
elif [ "$HOME" = "/home/brendon" ]; then
    echo "xdg-open not found, alias not created."
fi


if hash notify-send > /dev/null 2>&1; then
    # An "alert" alias for long running commands. ex.) pacman -Syyu; alert
    # sends notification containing the command name when it's done
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi


if hash utop > /dev/null 2>&1; then
    alias utop='eval $(opam env); utop'
else
    echo 'utop (ocaml REPL) not found, no alias created'
fi


if hash btm > /dev/null 2>&1; then
    # deprecated
    # alias top='ytop -p -c monokai'
    alias top='btm'
else
    echo 'ytop not found, no alias created'
fi


if hash mpv > /dev/null 2>&1; then
    alias mpv='setsid mpv --save-position-on-quit'
else
    echo 'mpv not found, no alias created'
fi


alias bell='echo -ne "\a"'



# ==================================================================== #
# ==================================================================== #
# ===============  setup_env/alias/desktop/desktop.sh  =============== #
# ==================================================================== #


# for when I make config changes that I want to commit to my ansible setup
alias ansb="cd $bash_dotfiles_root/../ansible/bash; ls"



# =================================================================== #
# =================================================================== #
# ===============  setup_env/alias/desktop/xrandr.sh  =============== #
# =================================================================== #


alias hdmi='xrandr --output HDMI1 --mode 1920x1080 --rate 60'

# monitors
# alias mon='mons -e right'
alias mon='mons -e left'
# ^--> my screen on left
# For multiple monitors consider changing to below, which works for 1 monitor
# xrandr --output $( xrandr | grep 'HDMI.* connected' | head -n1 | awk '{ print $1 }' ) --off
alias monoff='xrandr --output HDMI1 --off'

setup_monitor() {
    if [ $# -lt 1 ]; then
        echo "USAGE: setup_monitor MONITOR_SIDE"
        return
    fi
    local MONITOR_SIDE="$1"
    echo "mons -e $MONITOR_SIDE"
    # echo "$MONITOR_SIDE"
    mons -e "$MONITOR_SIDE" && bash "$HOME/.config/polybar/launch.sh" > /dev/null 2>&1
}
alias m=setup_monitor





# ===================================================================== #
# ===================================================================== #
# ===============  setup_env/alias/desktop/cmn_dirs.sh  =============== #
# ===================================================================== #


# ------ Common directory navigation ---------------------------------------
alias dow='cd "$dow"; ls'
alias submit='cd "$submit"; ls'
alias sem='cd "$sem"; ls'
alias scrot='cd ~/Pictures/Screenshots; ls; ranger'


# ------ Course directories ------------------------------------------------
alias cam='cd ~/Documents/Mcgill/5th-year/Winter/Compilers/Ocaml; ls'
alias 326='cd "$sem";  cd 326;             ls'
alias 321='cd "$sem";  cd Prog_challenges; ls'
alias 429='cd "$sem";  cd 429;             ls'
alias chem='cd "$sem"; cd Chem;            ls'
alias atmo='cd "$sem"; cd Atmosphere;      ls'


# ------ Random directories ------------------------------------------------
# mnemonic:  EclipseWorkspace
alias ework='cd /home/brendon/Downloads/programs/eclipse-workspace; ls'
alias print='cd ~/Scripts/my_projects/print; ls'

alias eclipse='cd /home/brendon/Downloads/programs/java-2019-06/eclipse; ./eclipse &'

alias mnt='cd /mnt/home/brendon'



# ======================================================================== #
# ======================================================================== #
# ===============  programs/git/desktop/config/aliases.sh  =============== #
# ======================================================================== #


#------------------ DOTFILES REPO ----------------------------------------------
#https://www.atlassian.com/git/tutorials/dotfiles

alias config='/usr/bin/git --git-dir="$HOME"/.cfg/ --work-tree="$HOME"'
# alias cadd='config add "$HOME"/.config/dotfiles/bash/configAdd.sh; source  "$HOME"/.config/dotfiles/bash/configAdd.sh'

SCRIPT_DIR="$bash_dotfiles_root"/programs/git/desktop/config
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
alias cadd='config add "$SCRIPT_DIR"/configAdd.sh; configAdd'
alias cpush='config push origin master'



# ============================================================ #
# ============================================================ #
# ===============  templates/alias/desktop.sh  =============== #
# ============================================================ #


# make this work with https://wiki.archlinux.org/index.php/backlight
# make sure to add curr user to video group !
alias bright='echo 255 | sudo tee /sys/class/backlight/amdgpu_bl0/brightness'



# =================================================================== #
# =================================================================== #
# ===============  programs/fzf/desktop/functions.sh  =============== #
# =================================================================== #


if ! hash rga > /dev/null 2>&1; then
    alias rgaf=rga_fzf
    rga_fzf() {
        local RG_PREFIX="rga --files-with-matches"
        local file
        file="$(
            FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
                fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                                --phony -q "$1" \
                                --bind "change:reload:$RG_PREFIX {q}" \
                                --preview-window="70%:wrap"
        )" &&
        echo "opening $file" &&
        setsid xdg-open "$file"
    }
else
    echo 'rga not found, rgaf alias not created'
fi



# ========================================================================== #
# ========================================================================== #
# ===============  programs/git/desktop/config/configAdd.sh  =============== #
# ========================================================================== #


# # in other file too but why needed here also since other is sourced first?
# alias config='/usr/bin/git --git-dir="$HOME"/.cfg/ --work-tree="$HOME"'

configAdd(){

    config add ~/.i3/config
    config add ~/.bashrc
    config add ~/.bash_profile
    config add ~/.profile
    config add ~/.vimrc
    config add ~/.latexmkrc
    config add ~/.gitconfig
    config add ~/.gitignore_global
    config add ~/.vim/after/plugin
    config add ~/.vimPlug/
    config add ~/readme.md

    config add ~/.config/dotfiles/
    config add ~/.config/polybar
    config add ~/.config/fusuma
    config add ~/.config/kitty
    config add ~/.config/nvim
    config add ~/.config/.ripgreprc
    config add ~/.config/compton.conf
    config add ~/.config/mimeapps.list
    config add ~/.config/zathura
    config add ~/.config/ptpython/config.py
    config add ~/.config/mpv/mpv.conf
    config add ~/.config/mpv/input.conf
    config add ~/.config/neofetch
    config add ~/.config/rofi
    config add ~/.config/dunst
    config add ~/.config/pavucontrol.ini
    config add ~/.config/w3m_Xresources


    config add ~/dev/dev/Scripts/battest_cronjob
    config add ~/dev/dev/Scripts/redshift_toggle.sh
    config add ~/dev/dev/Scripts/which_hw.sh
    config add ~/dev/dev/Scripts/i3_initial_layout.sh
    config add ~/dev/dev/Scripts/test-mode.sh
    config add ~/dev/dev/Scripts/open_roficalc.sh
    config add ~/dev/dev/Scripts/open_greenclip.sh
    config add ~/dev/dev/Scripts/default_rofi.sh
    config add ~/dev/dev/Scripts/backup_bash_history

    # Todo: change these paths to be in dotfiles


}
# alias cadd='configAdd && echo "did cadd !!"' # && config add "$bash_dotfiles_root"/programs/git/desktop/config/configAdd.sh'
# alias cadd='configAdd && config add "$bash_dotfiles_root"/programs/git/desktop/config/configAdd.sh'

# config add ~/dev/dev/Scripts/backup_bash_history
# TODO: fix this to proper path
# config add "$HOME"/.config/dotfiles/new_dotfiles
