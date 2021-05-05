#!/usr/bin/env bash


if [ $# -ne 2 ]; then
    echo "need 2 args (role, new_home_dir) for generate.sh"
    exit 1
fi
role="$1"
new_home_dir="$2"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ansible_root="$bash_dotfiles_root/../ansible/bash"
gen_script="$SCRIPT_DIR"/create_file_copy_vars.py


# ============= generate stuff for role:  'copy_bash_files'  ===================
bash "$SCRIPT_DIR"/generate_copy_vars.sh "$role" "$new_home_dir"



# ============= generate stuff for role:  'install_files'  =====================
generated_file="$bash_dotfiles_root"/../ansible/bash/roles/install_files/vars/main.yml

echo -e "---\n# This file is generated and overwritten by generate.sh\n" > "$generated_file"
python3 "$SCRIPT_DIR"/create_install_vars.py "$role" >> "$generated_file"
