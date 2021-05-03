#!/usr/bin/env bash


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

