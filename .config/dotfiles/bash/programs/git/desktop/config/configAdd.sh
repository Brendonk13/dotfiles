#!/usr/bin/env bash

# # in other file too but why needed here also since other is sourced first?
# alias config='/usr/bin/git --git-dir="$HOME"/.cfg/ --work-tree="$HOME"'

configAdd(){

    config add ~/.i3/config
    config add ~/.bashrc
    config add ~/.bash_profile
    config add ~/.profile
    config add ~/.vimrc
    config add ~/.latexmkrc
    config add ~/.gitconfig
    config add ~/.gitignore_global
    config add ~/.vim/after/plugin
    config add ~/.vimPlug/
    config add ~/readme.md

    config add ~/.config/dotfiles/
    config add ~/.config/polybar
    config add ~/.config/fusuma
    config add ~/.config/kitty
    config add ~/.config/nvim
    config add ~/.config/.ripgreprc
    config add ~/.config/compton.conf
    config add ~/.config/mimeapps.list
    config add ~/.config/zathura
    config add ~/.config/ptpython/config.py
    config add ~/.config/mpv/mpv.conf
    config add ~/.config/mpv/input.conf
    config add ~/.config/neofetch
    config add ~/.config/rofi
    config add ~/.config/dunst
    config add ~/.config/pavucontrol.ini
    config add ~/.config/w3m_Xresources


    config add ~/dev/dev/Scripts/battest_cronjob
    config add ~/dev/dev/Scripts/redshift_toggle.sh
    config add ~/dev/dev/Scripts/which_hw.sh
    config add ~/dev/dev/Scripts/i3_initial_layout.sh
    config add ~/dev/dev/Scripts/test-mode.sh
    config add ~/dev/dev/Scripts/open_roficalc.sh
    config add ~/dev/dev/Scripts/open_greenclip.sh
    config add ~/dev/dev/Scripts/default_rofi.sh
    config add ~/dev/dev/Scripts/backup_bash_history
    config add ~/dev/dev/Scripts/push_all_repos.sh

    # Todo: change these paths to be in dotfiles
    config rm --cached -r --quiet ~/.config/dotfiles/bash/sourced > /dev/null 2>&1
    config rm --cached -r --quiet ~/.config/dotfiles/vim/sourced > /dev/null 2>&1
}
# alias cadd='configAdd && echo "did cadd !!"' # && config add "$bash_dotfiles_root"/programs/git/desktop/config/configAdd.sh'
# alias cadd='configAdd && config add "$bash_dotfiles_root"/programs/git/desktop/config/configAdd.sh'

# config add ~/dev/dev/Scripts/backup_bash_history
# TODO: fix this to proper path
# config add "$HOME"/.config/dotfiles/new_dotfiles
