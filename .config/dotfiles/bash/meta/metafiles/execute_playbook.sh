#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

role='common'
# perform sed with site.yml maybe to add this automatically
new_user='test'
new_home_dir="/home/$new_user"
# IDEA: append role to group_vars and have site.yml have a bunch of diff clauses depending on this var's value

bash "$SCRIPT_DIR"/generate.sh "$role" "$new_home_dir"

cd "$bash_dotfiles_root"/../ansible/bash/ && ansible-playbook -kK -i inventory/hosts site.yml
