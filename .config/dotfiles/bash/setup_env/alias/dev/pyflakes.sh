#!/usr/bin/env bash


if hash pyflakes > /dev/null 2>&1; then
    # python linter, only checks syntax errors
    alias plint='pyflakes'
else
    echo 'pyflakes not found, plint alias not created'
fi
