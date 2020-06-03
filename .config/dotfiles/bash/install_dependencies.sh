#!/usr/bin/env bash

OS="$(uname)"
ALREADY_HAVE=''
DOWNLOAD_COMMAND=''
ARCH_BASED=false

if [ "$OS" = "Linux" ]; then

    # no solution seemed great online, everything has python tho
    DISTRO="$(python -m platform)"
    ALREADY_HAVE="hash"

    if echo "$DISTRO" | grep -i 'manjaro'> /dev/null 2>&1; then
        # set this cuz then I need to search in both arch and user repos.
        ARCH_BASED=true
    fi
    # DOWNLOAD_COMMAND="sudo pacman -S --noconfirm"



elif [ "$OS" = "Darwin" ]; then
    echo "darwin"
    ALREADY_HAVE="brew list"
    DOWNLOAD_COMMAND="brew install"
fi


failed_to_find=""
already_had=""
while IFS="" read -r p || [ -n "$p" ]
do
    if "$ALREADY_HAVE" "$p" > /dev/null 2>&1; then
        already_had="$already_had, $p"
        continue

    elif [ "$ARCH_BASED" = true ]; then
        # try to install via pacman, use yay if not
        sudo pacman -S --noconfirm "$p" || yay -S --noconfirm "$p"
    else
        "$DOWNLOAD_COMMAND " "$p"
    fi

    # keep track of packages which weren't downloaded
    if [ $? -ne 0 ]; then
        failed_to_find="$failed_to_find, $p"
    else
        printf '%s\n' "$p"
    fi
done < "$XDG_CONFIG_HOME"/dotfiles/bash/dotfile_dependencies.txt

GREEN='\033[1;32m'
RED='\033[0;31m'
NOCOL='\033[0m'

echo -e "${GREEN}Already had the following packages: ${NOCOL}"
echo -e "\t$already_had\n"

echo -e "${RED}Package install script failed to download the following packages: ${NOCOL}"
echo -e "\t$failed_to_find\n"
