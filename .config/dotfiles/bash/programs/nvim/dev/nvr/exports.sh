#!/usr/bin/env bash

# if we call vim __.x within nvim, use nvr and don't nest vim in terminal.
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr"
else
    export VISUAL="nvim"
fi
export EDITOR=$VISUAL

alias vim="$EDITOR"
alias vi="$EDITOR"
