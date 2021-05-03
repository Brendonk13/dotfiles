#!/usr/bin/env bash

# gives you devicons and nice colored output
if hash lsd > /dev/null 2>&1; then
    alias ls='lsd --group-dirs first'
    alias lsa='ls -A'
    # ls -l --total-size --blocks user,size,name
    alias ll='ls -l --total-size'
    # show file sizes
    alias lss='ls -l --blocks size,name'

    # todo: integrate and add other alias in case lsd non-existant on sys
    # purpose: lsd -l computes the size of a dir and can take a while
    # mnemonic: ls_Permissions
    alias lsp='lsd --blocks permission,user,group,name'
fi

