#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export XDG_CONFIG_HOME="$HOME/.config"
OS=`uname`

# google-chrome browser
if [[ "$OS" = "Linux" ]] && hash google-chrome-stable > /dev/null 2>&1; then
    export BROWSER=/usr/bin/google-chrome-stable
else
    echo '$BROWSER not set since google-chrome-stable was not found.'
fi

# rofi-pass
if hash rofi && hash rofi-pass > /dev/null 2>&1; then
    export ROFI_PASS_CONFIG="$HOME/.config/rofi-pass/config"
fi

# # neovim editor
# if [[ "$OS" = "Linux" ]] && hash nvim > /dev/null 2>&1; then
#     export EDITOR=/usr/bin/nvim
# else
#     echo '$EDITOR not set since /usr/bin/nvim was not found.'
# fi

# # kitty terminal
# if [[ "$OS" = "Linux" ]] && hash kitty > /dev/null 2>&1; then
#     export editor=/usr/bin/kitty
# else
#     echo '$editor not set since /usr/bin/nvim was not found.'
# fi


if [[ "$OS" = "Darwin" ]]; then
    brew list coreutils || brew install coreutils
    # make GNU commands available, need them for ls --group-directories
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
    alias ls="/usr/local/opt/coreutils/libexec/gnubin/ls"
fi
