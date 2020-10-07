#!/usr/bin/env bash

if [ -f $dotBashDir/shopts.sh ]; then
    source $dotBashDir/shopts.sh
else
    echo "shopts.sh script is NOT in the same directory as bash dotfiles"
    return
fi

if [ -f "$dotBashDir/create_history_backup_dirs.sh" ]; then
    source "$dotBashDir/create_history_backup_dirs.sh"
    # note that nothing is done if the dirs exist
    create_backup_directories "$HOME"
else
    echo "create_history_backup_dirs.sh script is NOT in the same directory as bash dotfiles"
    return
fi


# add this to prompt command !!!!!!! get extra randomness cuz only happens if we run cmd on 5th minute of an hour

# create a general file merging bash file!!!
# pass in base_dir and backup_dir arguments
# it creates a dir structure if not exists


# change so that I can hold more versions of files
# can I lock a file from being looked at by more than 1 process
#--------- use flock !!!!

randomly_save_history() {
    time="$(date +%H:%M | tr -d ':' | sed 's/^0*//')"
    every_four_mins=$(($time%4))

    if [ $every_four_mins -eq 0 ]; then
        save_history=$((3*$every_four_mins+$RANDOM%20))
        save_history=$(($save_history%5))

        # make more random !!!!
        if [ $save_history -eq 0 ]; then
            echo "Randomly saving history..."
            history -a
            # save current history (--random just in case to avoid race condition)
            bash "$HOME/dev/dev/Scripts/backup_bash_history" --random "$HOME/.history_copies/tmp/random_save"
            # clean current history
            update_history
        fi
    fi
}


HISTCONTROL=ignorespace:ignoredups
# Note that this is kind of useless now that I'm deleting all the duplicates
HISTIGNORE="exit:clear:pwd:mount*:umount*:ping*"

PROMPT_COMMAND="history -a; randomly_save_history"
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


save_to_rand_file(){
    # panic and save to random named file when bash closes just in case its a unexpected shutdown
    history -a
    bash "$HOME/dev/dev/Scripts/backup_bash_history" --random "$HOME/.history_copies/tmp/shutdown"
}


# Clean history file when bash starts.
clean_bash_history

# Clean history file when bash exits.
trap save_to_rand_file EXIT
