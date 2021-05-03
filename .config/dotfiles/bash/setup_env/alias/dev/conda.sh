#!/usr/bin/env bash

if hash conda > /dev/null 2>&1; then
    alias newc='conda create -n'
    alias remc='conda env remove --name'
    alias act='conda activate'
    alias deac='conda deactivate'
else
    echo 'conda not found, no aliases created'
fi
