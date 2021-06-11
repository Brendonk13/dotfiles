#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo "need 2 args (role, new_home_dir) for generate_copy_vars.sh"
    exit 1
fi
role="$1"
new_home_dir="$2"

ansible_root="$bash_dotfiles_root/../ansible/bash"
ansible_vars_file="$ansible_root/roles/copy_bash_files/vars/main.yml"



# =============== create group_vars file =======================
ansible_group_vars_file="$ansible_root/group_vars/all.yml"
echo -e "---\n#Note: this file is generated and overwritten by generate_copy_vars.sh file" > "$ansible_group_vars_file"
echo "home_dir: $new_home_dir" >> "$ansible_group_vars_file"
echo "role: $role" >> "$ansible_group_vars_file"
echo -e "\n" >> "$ansible_group_vars_file"




# reset file so we don't continuously append to this file
echo -e "---\n#Note: this file is generated and overwritten by generate_copy_vars.sh file" > "$ansible_vars_file"
echo -e "\n" >> "$ansible_vars_file"



exec_gen_script(){
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    gen_script="$SCRIPT_DIR"/create_file_copy_vars.py
    dotfile_base_dir="$new_home_dir/.config/dotfiles/bash"

    python3 "$gen_script" "$dotfile_base_dir" "$1"
}


create_variables(){
    local fil="$1"
    local var_name="$2"
    echo -e "$var_name:" >> "$ansible_vars_file"
    cat "$fil" >> "$ansible_vars_file"
    echo -e "\n\n" >> "$ansible_vars_file"
    rm "$fil"
}



# FIRST add vars for every file in role **NOT IN** $bash_dotfiles_root
file_with_paths="/tmp/dotfiles_copy_$role"

# generate file with paths for mass copying files in the role
source "$bash_dotfiles_root/generate_file_order.sh" && gen_files --role "$role" --out-file "$file_with_paths" --dont-set-last-role

exec_gen_script "$file_with_paths"
rm "$file_with_paths"



# SECOND add vars for every file in role **IN** $bash_dotfiles_root
file_with_paths="/tmp/root_dotfiles_copy_$role"

# generate file with paths for copying bash files in $bash_dotfiles_root dir
find "$bash_dotfiles_root" -maxdepth 1 -name '*.sh' > "$file_with_paths"

exec_gen_script "$file_with_paths"
rm "$file_with_paths"



create_variables '/tmp/src_file.txt' 'dotfile_sources'
create_variables '/tmp/dest_file.txt' 'dotfile_destinations'
create_variables '/tmp/ansb_directories.txt' 'created_dirs'
