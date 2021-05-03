#!/usr/bin/env bash

# if not running interactively then don't do anything
# added so that my bind cmd's dont give me grief over ssh
[ -z "$PS1" ] && return


# dotBashDir
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR"/export_dotfiles_root.sh
# bash_dotfiles_root="$HOME/.config/dotfiles/bash"


if ! [ -f "$bash_dotfiles_root"/meta/data/ordered_concatenated_files.txt ]; then
    bash "$SCRIPT_DIR"/concat_roles.sh
fi

IGNORE_OUTPUT='true'



DIR="$bash_dotfiles_root/sourced"
# LAST_ROLE="$(cat "$bash_dotfiles_root/sourced/last_role.txt")"
LAST_ROLE="$(cat "$bash_dotfiles_root/meta/data/last_role.txt")"
files=('minimal' 'common' 'dev' 'desktop')

for f in "${files[@]}"; do
    FILE="$DIR/$f.sh"

    if [ "$IGNORE_OUTPUT" = 'true' ]; then
        source "$FILE" > /dev/null 2>&1
    else
        echo "sourcing  -->  $FILE"
        source "$FILE"
    fi
    [ "$f" = "$LAST_ROLE" ] && break
done

hash neofetch > /dev/null 2>&1 && echo "" && neofetch | sed -e 's/^/  /' && echo ""
