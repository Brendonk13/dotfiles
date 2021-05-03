#!/usr/bin/env bash




# =============================================================================== #
# =============================================================================== #
# ===============  setup_env/debug/colors/minimal/8-16_compat.sh  =============== #
# =============================================================================== #


declare -A __COLORs

#this is sourced at the beginning of dotfiles, __cleanup_env_of_COLORs of colors meant to be called at the very end

__cleanup_env_of_COLORs() {
    unset __COLORs
}


__setup_COLORs() {
    __COLORs['NOCOL']='\033[0m'
    __COLORs['DEFAULT']='\033[0;39m'
    # __COLOs_['DEFAULT_B']='\033[1;39m'
    __COLORs['RED']='\033[0;31m'
    __COLORs['RED_B']='\033[1;31m'
    __COLORs['GREEN']='\033[0;32m'
    __COLORs['GREEN_B']='\033[1;32m'
    __COLORs['YELLOW']='\033[0;33m'
    __COLORs['YELLOW_B']='\033[1;33m'
    __COLORs['BLUE']='\033[0;34m'
    __COLORs['BLUE_B']='\033[1;34m'
    __COLORs['MAGENTA']='\033[0;35m'
    __COLORs['MAGENTA_B']='\033[1;35m'
    __COLORs['CYAN']='\033[0;36m'
    __COLORs['CYAN_B']='\033[1;36m'
    __COLORs['WHITE']='\033[0;97m'
    __COLORs['WHITE_B']='\033[1;97m'
    export __COLORs
    # echo "exported __COLORs_ = ${__COLORs_[*]}"
}


with_color() {
    no_col='\033[0m'
    # echo "$1"
    local msg="${2}${no_col}"
    case "$1" in
    # __COLOs_['DEFAULT_B']='\033[1;39m'
        nocol|NoCol|NOCOL|None|NONE)
            echo -e "${__COLORs[NOCOL]}${msg}"
            ;;
        default)
            echo -e "${__COLORs[DEFAULT]}${msg}"
            ;;
        RED|red)
            # echo 'red case'
            echo -e "${__COLORs[RED]}${msg}"
            ;;
        RED_B|red_b)
            echo -e "${__COLORs[RED_B]}${msg}"
            ;;
        GREEN|green)
            echo -e "${__COLORs[GREEN]}${msg}"
            ;;
        GREEN_B|green_b)
            echo -e "${__COLORs[GREEN_B]}${msg}"
            ;;
        YELLOW|yellow)
            echo -e "${__COLORs[YELLOW]}${msg}"
            ;;
        YELLOW_B|yellow_b)
            echo -e "${__COLORs[YELLOW_B]}${msg}"
            ;;
        BLUE|blue)
            echo -e "${__COLORs[BLUE]}${msg}"
            ;;
        BLUE_B|blue_b)
            echo -e "${__COLORs[BLUE_B]}${msg}"
            ;;
        MAGENTA|magenta)
            echo -e "${__COLORs[MAGENTA]}${msg}"
            ;;
        MAGENTA_B|magenta_b)
            echo -e "${__COLORs[MAGENTA_B]}${msg}"
            ;;
        CYAN|cyan)
            echo -e "${__COLORs[CYAN]}${msg}"
            ;;
        CYAN_B|cyan_b)
            echo -e "${__COLORs[CYAN_B]}${msg}"
            ;;
        WHITE|white)
            echo -e "${__COLORs[WHITE]}${msg}"
            ;;
        WHITE_B|white_b)
            echo -e "${__COLORs[WHITE_B]}${msg}"
            ;;

            *)
              echo 'Unknown color'
              return
            ;;
    esac
    # export __COLORs_
    # echo "exported __COLORs_ = ${__COLORs_[*]}"
}


t(){
    # echo 'in t'
    __setup_COLORs
    # echo -e "$(with_color 'RED' 'yo dudes')"
    # echo -e "$(with_color 'green' 'yo dudes')"
}
t



# ============================================================== #
# ============================================================== #
# ===============  setup_env/exports/minimal.sh  =============== #
# ============================================================== #



# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


export HISTFILESIZE=50000        # Max commands saved on disk
export HISTSIZE=20000            # per session history buffer size

# might as well have this
export bash_dotfiles_root="$HOME/.config/dotfiles/bash"




# ======================== SETUP PS1 PROMPT ====================================

SUPPORTS_ARROW=''

# set SUPPORTS_ARROW true if we are in ssh session
# if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
#   SUPPORTS_ARROW='true'
# # many other tests omitted
# else
#   case $(ps -o comm= -p $PPID) in
#     sshd|*/sshd) SUPPORTS_ARROW='true';;
#   esac
# fi

case "$TERM" in
    xterm*)
        SUPPORTS_ARROW='true' ;;
    *)
        # allows for backspace over ssh :)
        export TERM=vt100 ;;
esac


# show max 5 directories (probs nice cuz this will probs be used on machines that I am unfamiliar with
curr_parent='${PWD#"${PWD%/*/*/*/*/*}/"}'


if [ "$SUPPORTS_ARROW" = 'true' ] ; then
    # the arrow only works when I ssh from a term emulator that supports it
    export PS1=" \[\e[01;31m\][\[\e[m\]\u@\h\\[\e[01;31m\]]\[\e[m\] \[\e[33m\]-\[\e[m\] \@ \[\e[33m\]-\[\e[m\] \[\e[01;31m\][\[\e[m\]$curr_parent\[\e[01;31m\]] \[\e[m\]\n  ⤷ \[\e[32m\]\\$\\$\[\e[m\] "
else
    # for when not connected over ssh
    export PS1=" \[\e[01;31m\][\[\e[m\]\u@\h\\[\e[01;31m\]]\[\e[m\] \[\e[33m\]-\[\e[m\] \@ \[\e[33m\]-\[\e[m\] \[\e[01;31m\][\[\e[m\]$curr_parent\[\e[01;31m\]] \[\e[m\]\n  \[\e[32m\]\$\[\e[m\]\[\e[32m\]\$\[\e[m\] "
fi




# ============================================================ #
# ============================================================ #
# ===============  setup_env/alias/minimal.sh  =============== #
# ============================================================ #



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



# ============================================================= #
# ============================================================= #
# ===============  setup_env/shopts/minimal.sh  =============== #
# ============================================================= #


bind 'set bell-style none'

## SMARTER TAB-COMPLETION (Readline bindings) ##
#
# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# use these to move by whitespace delim words
bind '"\C-f":vi-fWord'
bind '"\C-b":vi-bWord'

# correct minor spelling mistakes
shopt -s cdspell

# only suggest directories during tab completion of cd command
complete -d cd



# ======================================================================= #
# ======================================================================= #
# ===============  programs/built_ins/minimal/minimal.sh  =============== #
# ======================================================================= #

# ../../../bash/built_ins/minimal/minimal.sh

storeCurrentDirectory() {
    D="$(pwd)"
}
alias cpd=storeCurrentDirectory


# follow moved files to the dest. folder
function mcd() {
    if [ "$#" -lt 2 ]; then
        echo "Input files and destination for this to work jeez."
        echo "Next time enter more than 1 argument: mcd files dest."
        return
    fi
    local file_destination=${@:$#}
    local num_files=$#

    # num_files is originally counting files and the destination dir
    # so shift one less time than $#
    num_files=$(($num_files - 1))

    while [ "$num_files" -gt 0 ]; do
        mv "$1" "$file_destination"
        num_files=$(($num_files - 1))
        shift
    done

    echo "";  echo " ----- DESTINATION DIR CONTENTS:";
    cd "$file_destination"
    if hash lsd > /dev/null 2>&1; then
        lsd --group-dirs first
    else
        ls --group-directories --color
    fi
    echo ""
}


changeft() {
    echo "better mv file.{old_ft,new_ft}"
    if [ $# -lt 2 ]; then
        echo "USAGE: chgft *.txt ft"
        return
    fi
    local FT=${@:$#}
    local num_files=$#

    # num_files is originally counting files and the destination dir
    # so shift one less time than $#
    num_files=$(($num_files - 1))

    local new_name
    local old_name
    while [ "$num_files" -gt 0 ]; do
        old_name="$1"
        new_name="${old_name%%.*}.${FT}"
        echo "new name: $new_name"
        num_files=$(($num_files - 1))
        # mv "$old_name" "$new_name"
        shift
    done
}
alias cft=changeft


# moves up $1 directories
function up() {
  local times=$1
  while [ "$times" -gt "0" ]; do
    cd ..
    times=$(($times - 1))
  done
}


# function changeDirAndShow() {
#     cd "$1" && ls -A
# }
# alias cdl=changeDirAndShow
# alias cdl..='cdl ..'



# ================================================================= #
# ================================================================= #
# ===============  programs/git/minimal/minimal.sh  =============== #
# ================================================================= #


# -------------- GITHUB --------------------------------------------------------
if hash git > /dev/null 2>&1; then
    alias g='git'
    # alias gcom='git commit -m'
else
    echo "git not found, no alias (g=git) created."
fi

