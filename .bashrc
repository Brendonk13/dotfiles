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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'

    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


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


if [ -f $dotBashDir/.bash_exports ]; then
    source $dotBashDir/.bash_exports
fi

if [ -f $dotBashDir/.bash_aliases ]; then
    source $dotBashDir/.bash_aliases
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



#betterBash has functions and a few common alias's 
if [ -f $dotBashDir/.betterBash ]; then
    source $dotBashDir/.betterBash
fi

#https://www.atlassian.com/git/tutorials/dotfiles this is what made me decide to add below alia
# I can now selectively add files in my home directory to a repo
alias config='/usr/bin/git --git-dir=/home/brendonk/.cfg/ --work-tree=/home/brendonk'




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

# note that I changed from grep to ag, hopefully still works
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

export PS1="\`parse_git_branch\`  \[\e[33m\]-\[\e[m\]  \@ \[\e[33m\]-\[\e[m\] \[\e[31m\][\[\e[m\] $curr_parent \[\e[31m\]] \[\e[m\]\[\e[32m\]\\$\[\e[m\] "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#export LS_COLORS="$(vivid generate ayu)"
#eval `dircolors $dotBashDir/dircolors.moonshine`
#LS_COLORS=$LS_COLORS:'ow=01;93;100'


if [ -f ~/.dir_colors ]; then
    eval `dircolors ~/.dir_colors`
fi

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
#export LIBGL_ALWAYS_INDIRECT=1
