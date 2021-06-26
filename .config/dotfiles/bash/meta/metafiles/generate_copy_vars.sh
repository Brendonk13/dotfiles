#!/usr/bin/env bash

# if [ $# -ne 4 ]; then
#     echo "need 2 args (role, new_home_dir, generated_for) for generate_copy_vars.sh"
#     exit 1
# fi
# role="$1"
# new_home_dir="$2"
# generated_for="$3"
# new_dotfiles_root="$4"

if [ "$GENERATED_FOR" = 'bash' ]; then
    ansible_root="$bash_dotfiles_root/../ansible/bash"
    # ansible_vars_file="$ansible_root/roles/copy_bash_files/vars/main.yml"
else
    ansible_root="$bash_dotfiles_root/../ansible/vim"
fi
ansible_vars_file="$ansible_root/roles/copy_${GENERATED_FOR}_files/vars/main.yml"



# =============== create group_vars file =======================
ansible_group_vars_file="$ansible_root/group_vars/all.yml"
echo -e "---\n#Note: this file is generated and overwritten by generate_copy_vars.sh file\n" > "$ansible_group_vars_file"
echo "home_dir: $NEW_HOME_DIR" >> "$ansible_group_vars_file"
echo "role: ${ROLE}" >> "$ansible_group_vars_file"
echo "new_dotfiles_root: $NEW_DOTFILES_ROOT" >> "$ansible_group_vars_file"
echo "current_dotfiles_root: $CURRENT_DOTFILES_ROOT" >> "$ansible_group_vars_file"





# reset file so we don't continuously append to this file
echo -e "---\n#Note: this file is generated and overwritten by generate_copy_vars.sh file\n\n" > "$ansible_vars_file"



exec_gen_script(){
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    gen_script="$SCRIPT_DIR"/create_file_copy_vars.py

    if [ "$GENERATED_FOR" = 'bash' ]; then
        dotfile_base_dir="$NEW_HOME_DIR/.config/dotfiles/bash"
    else
        dotfile_base_dir="$NEW_HOME_DIR/.config/dotfiles/vim"
    fi

    # $1 is a file containing file names to-be-copied
    python3 "$gen_script" "$dotfile_base_dir" "$1"
}


# ========= FIRST add vars for every file in role **NOT IN** $bash_dotfiles_root
file_with_paths="/tmp/dotfiles_copy_$ROLE"

# generate file with paths for mass copying files in the role
if [ "$GENERATED_FOR" = 'bash' ]; then
    source "$bash_dotfiles_root/generate_file_order.sh" && gen_files --role "$ROLE" --out-file "$file_with_paths" --dont-set-last-role
else
    python3 "$CURRENT_DOTFILES_ROOT"/meta/metafiles/generate_file_order.py --role "$ROLE" --out-file "$file_with_paths"
fi

exec_gen_script "$file_with_paths" && rm "$file_with_paths"

if [ "$GENERATED_FOR" = 'vim' ]; then
    exec_gen_script "${file_with_paths}_plugins"
    rm "${file_with_paths}_plugins"
fi



# ============ SECOND add vars for every file in role **IN** $bash_dotfiles_root
if [ "$GENERATED_FOR" = 'bash' ]; then
    file_with_paths="/tmp/root_dotfiles_copy_$ROLE"

    # generate file with paths for copying bash files in $bash_dotfiles_root dir
    find "$bash_dotfiles_root" -maxdepth 1 -name '*.sh' > "$file_with_paths"

    exec_gen_script "$file_with_paths"
    rm "$file_with_paths"
fi





create_variables(){
    local fil="$1"
    local var_name="$2"
    echo -e "$var_name:" >> "$ansible_vars_file"
    # fil contains all the variables in yaml format
    cat "$fil" >> "$ansible_vars_file"
    echo -e "\n\n" >> "$ansible_vars_file"
    rm "$fil"
}

# these files are created by the python script: create_file_copy_vars
create_variables '/tmp/src_file.txt' 'dotfile_sources'
create_variables '/tmp/dest_file.txt' 'dotfile_destinations'
create_variables '/tmp/ansb_directories.txt' 'created_dirs'

