#!/usr/bin/env bash

if hash bat > /dev/null 2>&1; then
    # alias cat='bat'
    alias c='bat'
    alias cat='bat -P'
else
    echo "bat not found, alias c=cat made instead."
    alias c='cat'
fi

