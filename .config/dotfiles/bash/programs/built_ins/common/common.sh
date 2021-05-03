#!/usr/bin/env bash


# mv
renameSameFiletype() {
    # mv wrapper, behaves the same in all but 1 case
    # if $1 has a ft and $2 does not (AND $# == 2)
    # then the second arg gets the ft of $1
    if [ $# -lt 2 ]; then
        echo "USAGE: mv file1.txt file2"
        return 1
    fi
    if [ $# -eq 2 ]; then
        local arg_with_ft="$1"
        local new_name="$2"
        if [ -f "$arg_with_ft" ] && [[ "$arg_with_ft" == *.* ]]; then
            if [[ "$new_name" != *.* ]]; then
                # if $new_name already has a filetype, don't change it (mimic 'mv' behaviour)
                if [ ! -d "$new_name" ]; then
                    # We don't want to append $ft to $new_name if it is a dir !
                    local ft="${arg_with_ft#*.}"
                    new_name="${new_name%%.*}.${ft}"
                    echo -e "$(with_color 'cyan' "new name:") $new_name"
                    \mv "$arg_with_ft" "$new_name"
                    return 0
                fi
            fi
        fi
    fi
    # echo 'normal mv'
    \mv "$@"
    # echo "mv $@"
}
# mvf: move file (not meant for dirs so appropiate)
alias mv=renameSameFiletype

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

