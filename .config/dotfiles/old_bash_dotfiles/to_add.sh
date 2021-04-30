#!/usr/bin/env bash

# correct minor spelling mistakes
shopt -s cdspell

# only suggest directories during tab completion of cd command
complete -d cd

function cd() {
    if [ "$#" = 0 ]; then
        pushd "$HOME" > /dev/null
    elif [ -f "$1" ]; then
        "$EDITOR" "$1"
    else
        pushd "$1" > /dev/null
    fi
}

# mnemonic back directory
# can provide a count
function bd() {
    if [ "$#" = 0 ]; then
        popd "$HOME" > /dev/null
    else
        for i in "$(seq ${1})"
        do
            popd "$1" > /dev/null
        done
    fi
}


# Usage: mark @name   -- create a bookmark
#        cd   @name   -- cd to bookmark
#        cd   @tab    -- list bookmarks
#        cd   @n<tab> -- complete with bookmark name
#        cd   @name/<tab> -- complete with subdirectory name

# CDPATH is a path of directories for cd to suggest you move to
export CDPATH=.:~/.marks
function mark() {
    ln -sr "$(pwd)" "~/.marks/$1"
}
