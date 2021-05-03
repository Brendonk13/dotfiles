#!/usr/bin/env bash

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


if hash ytop > /dev/null 2>&1; then
    alias top='ytop -p -c monokai'
else
    echo 'ytop not found, no alias created'
fi


if hash mpv > /dev/null 2>&1; then
    alias mpv='setsid mpv --save-position-on-quit'
else
    echo 'mpv not found, no alias created'
fi


alias bell='echo -ne "\a"'
