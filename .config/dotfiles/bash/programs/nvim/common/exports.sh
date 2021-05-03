#!/usr/bin/env bash

if hash nvim > /dev/null 2>&1; then
    export MANPAGER='nvim +Man!'
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR=$VISUAL
