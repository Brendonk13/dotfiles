#!/usr/bin/env bash

# if not running interactively then don't do anything
# added so that my bind cmd's dont give me grief over ssh
[ -z "$PS1" ] && return

XDG_CONFIG_HOME="$HOME/.config"
dotBashDir="$XDG_CONFIG_HOME/dotfiles/bash"

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


if [ -f $dotBashDir/.bash_exports ]; then
    source $dotBashDir/.bash_exports
fi

#betterBash has functions and a few common alias's 
if [ -f $dotBashDir/.betterBash ]; then
    source $dotBashDir/.betterBash
fi


if [ -f $dotBashDir/.bash_aliases ]; then
    source $dotBashDir/.bash_aliases
fi

if [ -f $dotBashDir/git-prompt.sh ]; then
    source $dotBashDir/git-prompt.sh
fi
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash


if cat /proc/version | grep Microsoft >/dev/null 2>&1; then

    if [ -f ~/FromInternet/z/z.sh ]; then
        source ~/FromInternet/z/z.sh
    fi
    export PATH=~/FromInternet/anaconda3/bin:$PATH

else
    # opam configuration -- ocaml
    test -r /home/brendon/.opam/opam-init/init.sh && . /home/brendon/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
fi

# this allows me to only show current and parent directory!
curr_parent='${PWD#"${PWD%/*/*}/"}'

export PS1='$(__git_ps1 "\[\e[01;31m\][\[\e[m\]%s\[\e[01;31m\]]\[\e[m\]")'
export PS1="$PS1  \[\e[33m\]-\[\e[m\]  \@ \[\e[33m\]-\[\e[m\] \[\e[01;31m\][\[\e[m\]$curr_parent\[\e[01;31m\]] \[\e[m\]\[\e[32m\]\\$\[\e[m\] "


((_ble_bash)) && ble-attach

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

# don't want fancy prompt on server
# if [ "$HOME" = "/home/brendon" ]; then
#     # get current branch in git repo
#     function parse_git_branch() {
#             BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
#                 if [ ! "${BRANCH}" == "" ]
#                 then
#                     STAT=`parse_git_dirty`
#                     echo "[${BRANCH}${STAT}]"
#                 else
#                     echo ""
#                 fi
#     }

#     # get current status of git repo
#     function parse_git_dirty {
#             status=`git status 2>&1 | tee`
#             dirty=`echo -n "${status}" 2> /dev/null | ag "modified:" &> /dev/null; echo "$?"`
#             untracked=`echo -n "${status}" 2> /dev/null | ag "Untracked files" &> /dev/null; echo "$?"`
#             ahead=`echo -n "${status}" 2> /dev/null | ag "Your branch is ahead of" &> /dev/null; echo "$?"`
#             newfile=`echo -n "${status}" 2> /dev/null | ag "new file:" &> /dev/null; echo "$?"`
#             renamed=`echo -n "${status}" 2> /dev/null | ag "renamed:" &> /dev/null; echo "$?"`
#             deleted=`echo -n "${status}" 2> /dev/null | ag "deleted:" &> /dev/null; echo "$?"`
#             bits=''

#             if [ "${renamed}" == "0" ]; then
#                 bits=">${bits}"
#             fi
#             if [ "${ahead}" == "0" ]; then
#                 bits="*${bits}"
#             fi
#             if [ "${newfile}" == "0" ]; then
#                 bits="+${bits}"
#             fi
#             if [ "${untracked}" == "0" ]; then
#                 bits="?${bits}"
#             fi
#             if [ "${deleted}" == "0" ]; then
#                 bits="x${bits}"
#             fi
#             if [ "${dirty}" == "0" ]; then
#                 bits="!${bits}"
#             fi
#             if [ ! "${bits}" == "" ]; then
#                 echo " ${bits}"
#             else
#                 echo ""
#             fi
#     }

