#!/usr/bin/env bash

if have_dependencies 'yay' 'fzf' 'xargs' 'pacman'; then

    # fuzzy search arch/AUR repositories then download
    function search_packages() {
        local pac_manager="$1"
        if [ "$pac_manager" == "yay" ]; then
            # "$pac_manager" -S --noconfirm "$package_name"
                yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S --noconfirm
            # sudo not recommended for yay installs
        else
            pacman -Slq  | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S --noconfirm
        #     sudo "$pac_manager" -S --noconfirm "$package_name"
        fi
    }

    # fuzzy search thru pacman -Slq then download package
    alias spac='search_packages pacman'
    # same for AUR
    alias syay='search_packages yay'
fi
