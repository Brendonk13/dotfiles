#!/usr/bin/env bash

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# gotta have tab complete
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# append to histfile, instead of overwriting
shopt -s histappend

# store multiline commands as one history entry
shopt -s cmdhist

# before: ls *(*txt|*sh) does NOT work
# Can now do advanced pattern matching: http://mywiki.wooledge.org/glob#extglob
shopt -s extglob

