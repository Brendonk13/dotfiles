#!/usr/bin/env bash

if [ -f $dotBashDir/shopts.sh ]; then
    source $dotBashDir/shopts.sh
else
    echo "shopts.sh script is NOT in the same directory as bash dotfiles"
    return
fi

HISTCONTROL=ignorespace:ignoredups
HISTIGNORE="exit:cd*:clear:pwd:mount*:umount*:ping*"

PROMPT_COMMAND="history -a"
# Below link explains that this command is run right before bash displays: $PS1
# https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x264.html (try: PROMPT_COMMAND="date +%H%M")

# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history/18443#18443
# this solution works bad but not awfully, from above link

# Cleans the history file, removing all duplicate entries.
clean_bash_history() {
    mkdir -p /tmp/"$USER"_history
    tac ~/.bash_history > /tmp/"$USER"_history/bash_history_dirty

    # if a command appears in history twice, then we delete the first entry of that command!
    awk '!visited[$0]++' /tmp/"$USER"_history/bash_history_dirty > /tmp/"$USER"_history/bash_history_cleaned
    tac /tmp/"$USER"_history/bash_history_cleaned > ~/.bash_history
}

# Use this command to update your session's history whenever you want new entries from other sessions.
update_history() {
    history -a
    clean_bash_history
    history -c
    history -r
}

# Clean history file when bash starts.
clean_bash_history

# Clean history file when bash exits.
trap clean_bash_history EXIT
