#!/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

dotBashDir=~/dotfiles/bashh
alias ls='ls --group-directories-first --color=auto'

#set -o vi    # vim mode in bash upon pressing escape!
#bind "set show-mode-in-prompt on"
# think my plan with this might be to use normal emacs readline on
# then maybe add these commands to vim's command line editing 
# note that I could get similar functionality to vim, ie bind ci" to f"f"cT" 
# but rlly don't like how there is a lag between <esc> and exiting the mode..


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# An "alert" alias for long running commands.
# sends notification containing the command the command when it's done
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# Different prompt for when I'm on windows
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
    echo ""
    neofetch | sed -e 's/^/  /'
    echo ""
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


if [ -f $dotBashDir/.bash_exports ]; then
    source $dotBashDir/.bash_exports
fi

if [ -f $dotBashDir/.bash_aliases ]; then
    source $dotBashDir/.bash_aliases
fi

#betterBash has functions and a few common alias's 
if [ -f $dotBashDir/.betterBash ]; then
    source $dotBashDir/.betterBash
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash





if cat /proc/version | grep Microsoft >/dev/null 2>&1; then

    if [ -f ~/FromInternet/z/z.sh ]; then
        source ~/FromInternet/z/z.sh
    fi
    export PATH=~/FromInternet/anaconda3/bin:$PATH

else
    if [ -f /usr/share/z/z.sh ]; then
        source /usr/share/z/z.sh
    fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/brendonk/FromInternet/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/brendonk/FromInternet/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/brendonk/FromInternet/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/brendonk/FromInternet/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# get current branch in git repo
function parse_git_branch() {
        BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
            if [ ! "${BRANCH}" == "" ]
            then
                STAT=`parse_git_dirty`
                echo "[${BRANCH}${STAT}]"
            else
                echo ""
            fi
}

# get current status of git repo
function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | ag "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | ag "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | ag "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | ag "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | ag "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | ag "deleted:" &> /dev/null; echo "$?"`
        bits=''

        if [ "${renamed}" == "0" ]; then
            bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
            bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
            bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
            bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
            bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
            bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
            echo " ${bits}"
        else
            echo ""
        fi
}

# this allows me to only show current and parent directory!
curr_parent='${PWD#"${PWD%/*/*}/"}'

export PS1="\`parse_git_branch\`  \[\e[33m\]-\[\e[m\]  \@ \[\e[33m\]-\[\e[m\] \[\e[01;31m\][\[\e[m\]$curr_parent\[\e[01;31m\]] \[\e[m\]\[\e[32m\]\\$\[\e[m\] "

