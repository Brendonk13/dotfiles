#!/usr/bin/env bash

if hash ptpython > /dev/null 2>&1; then
    export PYTHONSTARTUP="$HOME/.config/ptpython/config.py"
else
    echo 'ptpython not found, PYTHONSTARTUP not exported'
fi


if [ -f /usr/share/z/z.sh ]; then
    # location on arch linux
    export _Z_DATA="$HOME/.config/.z_data_file"
else
    echo 'z not found, _Z_DATA not exported'
fi

# for bash history backups
export MAX_HIST_BACKUPS=20
