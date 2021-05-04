#!/usr/bin/env bash


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ansible_root="$bash_dotfiles_root/../ansible/bash"
gen_script="$SCRIPT_DIR"/create_file_copy_vars.py

role='common'


new_user='test'
new_home_dir="/home/$new_user"
# new_home_dir='/root'
ansible_vars_file="$ansible_root/roles/$role/vars/main.yml"

# reset file so we don't continuously append to this file
echo -e "---\n#Note: this file is generated and overwritten by generate.sh file" > "$ansible_vars_file"
echo "home_dir: $new_home_dir" >> "$ansible_vars_file"
echo "role: $role" >> "$ansible_vars_file"
echo -e "\n" >> "$ansible_vars_file"


dotfile_base_dir="$new_home_dir/.config/dotfiles/bash"



exec_gen_script(){
    # generated_file="$1"
    # file_with_paths="$2"
    python3 "$gen_script" "$dotfile_base_dir" "$1" "$2" "$3"
    # python3 "$gen_script" "$dotfile_base_dir" "$role" "$1" "$2"
}





# generated_file="$ansible_root/roles/$role/tasks/mass_copy.yml"
var_name='role_files'
generated_file="$ansible_root/roles/$role/vars/main.yml"
file_with_paths="/tmp/dotfiles_copy_$role"

# generate file with paths for mass copying files in the role
source "$bash_dotfiles_root/generate_file_order.sh" && gen_files --role "$role" --out-file "$file_with_paths" --dont-set-last-role

exec_gen_script "$generated_file" "$file_with_paths" "$var_name"
rm "$file_with_paths"





# generated_file="$ansible_root/roles/$role/tasks/copy_dotfile_generator_scripts.yml"
var_name='dotfile_generator_scripts'
generated_file="$ansible_root/roles/$role/vars/main.yml"
file_with_paths="/tmp/root_dotfiles_copy_$role"

# generate file with paths for copying bash files in $bash_dotfiles_root dir
find "$bash_dotfiles_root" -maxdepth 1 -name '*.sh' > "$file_with_paths"

exec_gen_script "$generated_file" "$file_with_paths" "$var_name"
rm "$file_with_paths"



echo -e "dotfile_sources:" >> "$ansible_vars_file"
cat /tmp/src_file.txt >> "$ansible_vars_file"
echo -e "\n\n" >> "$ansible_vars_file"

echo -e "dotfile_destinations:" >> "$ansible_vars_file"
cat /tmp/dest_file.txt >> "$ansible_vars_file"
echo -e "\n\n" >> "$ansible_vars_file"

echo -e "created_dirs:" >> "$ansible_vars_file"
cat /tmp/ansb_directories.txt >> "$ansible_vars_file"
echo "  - $new_home_dir/.config/dotfiles/bash/meta/data" >> "$ansible_vars_file"
echo "  - $new_home_dir/.config/dotfiles/bash/sourced" >> "$ansible_vars_file"
echo -e "\n\n" >> "$ansible_vars_file"


rm /tmp/src_file.txt
rm /tmp/dest_file.txt
rm /tmp/ansb_directories.txt



# install files generation


generated_file="$bash_dotfiles_root"/../ansible/bash/roles/install_files/vars/main.yml
echo -e "---\n# This file is generated and overwritten by generate.sh\nrole: $role\n" > "$generated_file"
python3 "$SCRIPT_DIR"/create_install_vars.py "$role" >> "$generated_file"
