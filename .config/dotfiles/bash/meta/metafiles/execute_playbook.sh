#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "ERROR execute_playbook.sh called without arg: 'bash' or 'vim'"
    exit 0
fi
export GENERATED_FOR="$1"

# TODO: generate snippet for site.yml
export ROLE='common'

# perform sed with site.yml maybe to add this automatically
# new_user='test'
export NEW_USER='prom'
export NEW_HOME_DIR="/home/$NEW_USER"
# IDEA: append role to group_vars and have site.yml have a bunch of diff clauses depending on this var's value


if [ "$GENERATED_FOR" = 'bash' ]; then
    playbook_dir="$bash_dotfiles_root"/../ansible/bash
    export NEW_DOTFILES_ROOT="$NEW_HOME_DIR"/.config/dotfiles/bash
    export CURRENT_DOTFILES_ROOT="$bash_dotfiles_root"
elif [ "$GENERATED_FOR" = 'vim' ]; then
    playbook_dir="$bash_dotfiles_root"/../ansible/vim
    export NEW_DOTFILES_ROOT="$NEW_HOME_DIR"/.config/dotfiles/vim
    export CURRENT_DOTFILES_ROOT="$HOME/.config/dotfiles/vim"
else
    echo "pass arg: 'bash' or 'vim'"
    exit 0
fi



SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# echo "execute_playbook.sh: export vim_dotfiles_root='/home/brendon/.config/dotfiles/vim'"
# export vim_dotfiles_root="/home/brendon/.config/dotfiles/vim"



echo 'update execute_playbook to use a .vault file'

# bash "$SCRIPT_DIR"/generate.sh "$role" "$new_home_dir" "$generated_for" "$new_dotfiles_root"
bash "$SCRIPT_DIR"/generate.sh
echo 'would exec playbook now'
# echo 'NOTE: need to add support for copying the .plug_name files'
# cd "$playbook_dir" && ansible-playbook -kK -i inventory/hosts site.yml
