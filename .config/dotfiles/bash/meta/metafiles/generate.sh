#!/usr/bin/env bash


# if [ $# -ne 4 ]; then
#     echo "need 2 args (role, new_home_dir, generated_for) for generate.sh"
#     exit 1
# fi
# role="$1"
# new_home_dir="$2"
# generated_for="$3"
# NEW_DOTFILES_ROOT="$4"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# gen_script="$SCRIPT_DIR"/create_file_copy_vars.py

# if [ "$GENERATED_FOR" = 'bash' ]; then
#     ansible_root="$bash_dotfiles_root/../ansible/bash"
# else
#     ansible_root="$bash_dotfiles_root/../ansible/vim"
# fi


# ============= generate stuff for role:  'copy_bash_files'  ===================
bash "$SCRIPT_DIR"/generate_copy_vars.sh #"$ROLE" "$NEW_HOME_DIR" "$GENERATED_FOR" "$NEW_DOTFILES_ROOT"



# ============= generate stuff for role:  'install_files'  =====================
if [ "$GENERATED_FOR" = 'bash' ]; then
    generated_file="$bash_dotfiles_root"/../ansible/bash/roles/install_files/vars/main.yml

    echo -e "---\n# This file is generated and overwritten by generate.sh\n" > "$generated_file"
    python3 "$SCRIPT_DIR"/create_install_vars.py "$ROLE" >> "$generated_file"
else
    # generated_file="$bash_dotfiles_root"/../ansible/vim/roles/install_files/vars/main.yml
    echo 'Install files not implemented for vim'
fi
