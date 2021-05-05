
# What here why ?? !

**what:** stuff for generating ansible tasks

**here:** stuff here not added to ../data/ordered_concatenated_files.txt

**why:** cuz i dont want this stuff sourced from .bashrc !

## Conditions needed for use:
- set bash_dotfiles_root in export_dotfiles_root.sh (to directory containing this file)
- set variables: role, new_user in $bash_dotfiles_root/meta/metafiles/execute_playbook.sh

## Usage:
``` bash execute_playbook.sh ```
