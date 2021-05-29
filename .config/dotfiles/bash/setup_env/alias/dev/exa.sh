#!/usr/bin/env bash

if hash exa > /dev/null 2>&1; then
    alias ls='exa --group-directories-first'
    alias lsa='ls -a'

    alias ll='ls -l --git --no-time -h --group'

    # ls full
    alias lf='ls -l --git -h -i -H --group'
fi
