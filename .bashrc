#!/usr/bin/env bash

# if not running interactively then don't do anything
# added so that my bind cmd's dont give me grief over ssh
[ -z "$PS1" ] && return

XDG_CONFIG_HOME="$HOME/.config"
dotBashDir="$XDG_CONFIG_HOME/dotfiles/bash"

# ble gives fish shell style command completion as you type.
ble_path="$XDG_CONFIG_HOME/ble-0.3.2/ble.sh"
rc_file="$(dirname $ble_path)/src/ble.sh/blerc"
[[ $- == *i* ]] && [[ -f "$ble_path" ]] && source "$ble_path" --noattach --rcfile "$rc_file"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Different prompt for when I'm on windows
# Todo: check that /proc/version exists
if cat /proc/version | grep Microsoft >/dev/null 2>&1; then

    # echo's for formatting
    echo ""; echo -n " --- "
    #send weather report to tempfil
    curl -s "wttr.in/$1?m1" > tempfil.txt

    # remove last line of some guy begging to follow his twitter
    sed -i '$ d' tempfil.txt
    cat tempfil.txt;  rm tempfil.txt

    #append --'s to beginning of alias file, store in tempfil
    sed -e 's/^/ ----- /' $dotBashDir/bash_to_remember.txt > tempfil.txt
    cat tempfil.txt;  rm tempfil.txt
    echo ""

else
    # having echo's in bashrc makes it impossible to cp files over ssh provided the echo exists in the server's .bashrc
    if [ "$HOME" = "/home/brendon" ]; then
        hash neofetch && echo ""; neofetch | sed -e 's/^/  /'; echo ""
    fi

fi


# gotta have tab complete
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi


if [ -f $dotBashDir/exports.sh ]; then
    source $dotBashDir/exports.sh
fi

#betterBash has functions and a few common alias's 
if [ -f $dotBashDir/functions.sh ]; then
    source $dotBashDir/functions.sh
fi


if [ -f $dotBashDir/aliases.sh ]; then
    source $dotBashDir/aliases.sh
fi


# this shows repo info in prompt
if [ -f $dotBashDir/git-prompt.sh ]; then
    source $dotBashDir/git-prompt.sh
fi
# this allows me to only show current and parent directory!
curr_parent='${PWD#"${PWD%/*/*}/"}'

if [ -f $dotBashDir/git-prompt.sh ]; then
    export PS1='$(__git_ps1 " \[\e[01;31m\][\[\e[m\]%s\[\e[01;31m\]]\[\e[m\]")'
else
    export PS1=''
fi

export PS1="$PS1  \[\e[33m\]-\[\e[m\]  \@ \[\e[33m\]-\[\e[m\] \[\e[01;31m\][\[\e[m\]$curr_parent\[\e[01;31m\]] \[\e[m\]\[\e[32m\]\\$\[\e[m\] "

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash


# Note: this file exists on win10 and manjaro but not mac so change to uname output one day
# NOTE: changed to uname in .bash_profile
#   - check if uname command exists on win10 before changing everywhere.
if cat /proc/version | grep Microsoft >/dev/null 2>&1; then

    if [ -f ~/FromInternet/z/z.sh ]; then
        source ~/FromInternet/z/z.sh
    fi
    export PATH=~/FromInternet/anaconda3/bin:$PATH

else
    # opam configuration -- ocaml
    test -r /home/brendon/.opam/opam-init/init.sh && . /home/brendon/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
fi

bind 'set bell-style none'

## SMARTER TAB-COMPLETION (Readline bindings) ##
#
# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Don't record some commands -- who cares if they only show up once!
#export HISTIGNORE="&:[ ]*:exit:ls:history:clear"


# this stores the dir this script is in!
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if hash ble-attach; then
    ((_ble_bash)) && ble-attach
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/brendonk/FromInternet/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/brendonk/FromInternet/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/brendonk/FromInternet/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/brendonk/FromInternet/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<
