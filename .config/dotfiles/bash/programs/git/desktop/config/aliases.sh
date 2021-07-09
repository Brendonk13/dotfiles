#!/usr/bin/env bash

#------------------ DOTFILES REPO ----------------------------------------------
#https://www.atlassian.com/git/tutorials/dotfiles

alias config='/usr/bin/git --git-dir="$HOME"/.cfg/ --work-tree="$HOME"'
# alias cadd='config add "$HOME"/.config/dotfiles/bash/configAdd.sh; source  "$HOME"/.config/dotfiles/bash/configAdd.sh'

SCRIPT_DIR="$bash_dotfiles_root"/programs/git/desktop/config
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
alias cadd='config add "$SCRIPT_DIR"/configAdd.sh; configAdd > /dev/null 2>&1'
# alias cadd='config add "$SCRIPT_DIR"/configAdd.sh; configAdd; config rm --cached -r ~/.config/dotfiles/bash/sourced/; config rm --cached -r ~/.config/dotfiles/vim/sourced/'
#     config rm --cached -r '~/.config/dotfiles/bash/sourced'
#     config rm --cached -r '~/.config/dotfiles/vim/sourced'
alias cpush='config push origin master'
