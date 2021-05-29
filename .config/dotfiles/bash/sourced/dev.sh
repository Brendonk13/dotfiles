#!/usr/bin/env bash




# ================================================================== #
# ================================================================== #
# ===============  setup_env/exports/dev/ripgrep.sh  =============== #
# ================================================================== #


export RIPGREP_CONFIG_PATH="$HOME/.config/.ripgreprc"




# ============================================================== #
# ============================================================== #
# ===============  setup_env/exports/dev/dev.sh  =============== #
# ============================================================== #


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



# ================================================================== #
# ================================================================== #
# ===============  programs/nvim/dev/nvr/exports.sh  =============== #
# ================================================================== #


# if we call vim __.x within nvim, use nvr and don't nest vim in terminal.
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr"
else
    export VISUAL="nvim"
fi
export EDITOR=$VISUAL

alias vim="$EDITOR"
alias vi="$EDITOR"



# ================================================================ #
# ================================================================ #
# ===============  setup_env/alias/dev/tcpdump.sh  =============== #
# ================================================================ #


# so I don't fill up my hdd when writing to a file lol..
alias tcpdump='tcpdump -c 1000'



# ============================================================== #
# ============================================================== #
# ===============  setup_env/alias/dev/conda.sh  =============== #
# ============================================================== #


if hash conda > /dev/null 2>&1; then
    alias newc='conda create -n'
    alias remc='conda env remove --name'
    alias act='conda activate'
    alias deac='conda deactivate'
else
    echo 'conda not found, no aliases created'
fi



# ================================================================ #
# ================================================================ #
# ===============  setup_env/alias/dev/builtin.sh  =============== #
# ================================================================ #


# The trailing space tells shell to look for aliases in other than first word of cmd
alias sudo='sudo '


# -------------- APPLICATIONS --------------------------------------------------




# ================================================================= #
# ================================================================= #
# ===============  setup_env/alias/dev/pyflakes.sh  =============== #
# ================================================================= #



if hash pyflakes > /dev/null 2>&1; then
    # python linter, only checks syntax errors
    alias plint='pyflakes'
else
    echo 'pyflakes not found, plint alias not created'
fi



# ============================================================ #
# ============================================================ #
# ===============  setup_env/alias/dev/exa.sh  =============== #
# ============================================================ #


if hash exa > /dev/null 2>&1; then
    alias ls='exa --group-directories-first'
    alias lsa='ls -a'

    alias ll='ls -l --git --no-time -h --group'

    # ls full
    alias lf='ls -l --git -h -i -H --group'
fi



# ============================================================ #
# ============================================================ #
# ===============  setup_env/alias/dev/dev.sh  =============== #
# ============================================================ #


alias behave='behave --no-capture --no-capture-stderr --no-logcapture'



# ================================================================== #
# ================================================================== #
# ===============  setup_env/alias/dev/wireshark.sh  =============== #
# ================================================================== #


alias ws='setsid wireshark'



# ============================================================ #
# ============================================================ #
# ===============  setup_env/alias/dev/bat.sh  =============== #
# ============================================================ #


if hash bat > /dev/null 2>&1; then
    # alias cat='bat'
    alias c='bat'
    alias cat='bat -P'
else
    echo "bat not found, alias c=cat made instead."
    alias c='cat'
fi




# ============================================================= #
# ============================================================= #
# ===============  setup_env/source/dev/fzf.sh  =============== #
# ============================================================= #


[ -f "$XDG_CONFIG_HOME/.fzf_setup.sh" ] && source "$XDG_CONFIG_HOME/.fzf_setup.sh"
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash



# ============================================================================ #
# ============================================================================ #
# ===============  not_portable/os_specific/arch_based/dev.sh  =============== #
# ============================================================================ #


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



# ================================================================= #
# ================================================================= #
# ===============  programs/fzf/dev/git_helpers.sh  =============== #
# ================================================================= #


if ! have_dependencies 'fzf' 'awk' 'git' 'xargs' 'cut'; then
    echo "Exiting with no functions sourced, fzf not found in: $0"
    exit 1
fi


# search through all branches and merge entered selection
fuzzyMerge() {
    # search for all merge conflicts upon merge, display conflicts if there are any
    git branch -a | fzf | awk '{print $NF}' | xargs git merge || git mergetool #showMergeConflicts
}
alias merg=fuzzyMerge


# search through all branches and check it out
fuzzySwitchBranch() {
    git branch -a | fzf | awk '{print $NF}' | xargs git checkout
}
alias co=fuzzySwitchBranch


fuzzyDeleteBranch() {
    # last column is the name we are looking for
    local chosen_branch
    chosen_branch="$(git branch -a | fzf | awk '{print $NF}')"
    [[ "$chosen_branch" = "" ]] && return

    local just_name
    if [[ "$chosen_branch" = remotes* ]]; then
        # delimited by /  only keep 3rd field of remotes/origin/branch_name
        just_name="$(echo "$chosen_branch" | cut -d '/' -f3)"
    else
        just_name="$chosen_branch"
    fi
    # delete the local branch
    git branch -D "$just_name"
    # delete remote branch
    [[ "$chosen_branch" = remotes* ]] && git push origin --delete "$just_name"
}
alias gbd=fuzzyDeleteBranch




# =========================================================== #
# =========================================================== #
# ===============  programs/fasd/dev/fasd.sh  =============== #
# =========================================================== #


if ! hash fasd > /dev/null 2>&1; then
    echo "fasd not found, no aliases properly created"
    # exit 1
fi
# Note that it is assumed that if im getting fasd that i already have fzf/rg

# fasd_cache="$HOME/.fasd-init-bash"
# if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
#     # eval "$(fasd --init auto)"
#     fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
# fi
# source "$fasd_cache"
# unset fasd_cache
# _fasd_bash_hook_cmd_complete v m j o zz


# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
v() {
    [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $VISUAL "${file}" || return 1
}

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
fuzzy_z() {
# z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
# alias z=fuzzy_z

# broken: z, xdg, sf no_args


# open any previously opened mp4,png,pdf,pptx,jpg,jpeg,gif
# detaches process from parent, ie can close terminal which opened the file
fuzzy_xdgopen() {
    [ $# -gt 0 ] && fasd -f "$*" | xargs -0 setsid xdg-open && return
    local file
    # setsid opens the file in a new session so the process will survive the parent process.
    file="$(fasd -Rfl | awk '/(^.*(\.mp4|\.png|\.pdf|\.pptx|\.jpg|\.jpeg|\.gif)$)/{print}' | fzf -1 -0 --no-sort +m)" && setsid xdg-open "${file}"
}
# alias o=fuzzy_xdgopen

# [ -f "$XDG_CONFIG_HOME/.fzf_setup.sh" ] && source "$XDG_CONFIG_HOME/.fzf_setup.sh"


# ------------------------------- Search For input in "fasd -Rfl" file list or from $PWD----------------------------
ssf() {
    local rg_command='rg --column --line-number --no-heading --fixed-strings --color "always"'
    local search=""
    printf -v search "%q" "$*"
    local files
    if [ $# -lt 1 ]; then
        #todo: fix without arguments
        local recents
        local fils
        recents="$(fasd -Rfl "$1")"
        fils="$(echo -e $recents | awk '!/(^.*\.mp4$)/{print}')"
        files=`eval $rg_command $search "{$fils[*]}" | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
    else
        files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
    fi

    [[ -n "$files" ]] && $VISUAL "$files"
}
# alias sf=ssf



# ============================================================================ #
# ============================================================================ #
# ===============  programs/hist_save/dev/make_dummy_files.sh  =============== #
# ============================================================================ #


#base_dir="$HOME/.history_copies/tmp/test"
#[ ! -d "$base_dir" ] && mkdir "$base_dir" && echo "mkdir $base_dir"
#
#echo -e "most merged" > "$base_dir/most_merged.txt"
#sleep 0.1
#
#echo -e "first\nsecond" > "$base_dir/hist_0.txt"
#
#echo -e "first\nsecond\nthird" > "$base_dir/hist_1.txt"
## merge hist1 hist2 = first second third
#
#echo -e "third\nfourth" > "$base_dir/hist_2.txt"
## merge most_merged hist3 = first second third fourth
#
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_3.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_4.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_5.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_6.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_7.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_8.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_9.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_10.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_11.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_12.txt"
#echo -e "fifth\nfourth\nfirst" > "$base_dir/hist_13.txt"
#sleep 1
#echo -e "rlly_long_thing_near_end\nafter_long_thing" > "$base_dir/hist_15.txt"
#sleep 1
#echo -e "after_long_thing\nrlly_long_thing_near_end" > "$base_dir/hist_14.txt"
## fifteen files in dir total
## merge most_merged hist4 = first second third fourth fifth
#
## echo "idfk" > "$base_dir/most_merged.txt"



# ============================================================================ #
# ============================================================================ #
# ===============  programs/hist_save/dev/backup_bash_history  =============== #
# ============================================================================ #


my_rand_func() {
    # Why use 10# ? -> I do math on these numbers so must ensure they all are base 10
    local first_num
    local second_num
    local third_num
    local final
    first_num=$((10#$RANDOM*111))
    # get hash of random thing in ram
    second_num="$(ls /tmp/ | sort -R | tail -n 1 | md5sum |  tr -d -c 0-9)"
    second_num=$((10#$second_num/(RANDOM*RANDOM)))
    # use $RANDOM again
    third_num=$((10#$RANDOM*61))
    # NEW:
    printf -v final "%d" "$final"
    echo "$final"

    # old BUGGY LINE:
    # echo "$((10#$first_num+10#$second_num+10#$third_num))"
}


generate_file_name() {
    local backup_dir="$1"
    if [ $# -eq 2 ]; then # give a --random filename to help with race conditions
        # only positive numbers with no leading zeros
        local RAND_NUM
        RAND_NUM="$(my_rand_func | tr -d - | sed 's/^0*//')"

        #TODO: fix this with base 10 number issue (is below the fix???)
        # local rand
        # printf -v rand "%d" "$*"
        echo "hist_$RAND_NUM.txt"
        return
    fi
    local next_backup_num
    next_backup_num="$(ls "$backup_dir" | wc -l)"
    # minus one since we count from zero plus there is another file in dir: most_merged.txt
    next_backup_num=$((next_backup_num-1))
    local backed_up_file="hist_$next_backup_num.txt"
    echo "$backed_up_file"
}


merge_backup_histories() {
    # NOTE: Removes duplicates while preserving the order of when commands were typed
    if [ $# -ne 1 ]; then
        echo -e "Wrong number of args passed\nNeed exactly 1 arg --> a directory\n(in backup_bash_history/merge_backup_histories)"
        return
    fi
    if [ ! -d "$1" ]; then
        echo -e "Input argument must be a directory\n(in backup_bash_history/merge_backup_histories)"
        return
    fi
    local backup_dir="$1"
    # num_merges_done=0
    echo "backup dir is: $backup_dir"
    local new_result="/tmp/new_result.txt"
    local most_merged="$backup_dir/most_merged.txt"

    # files made first are first in arr, v important to preserve order
    # have the nr>1 to skip first line from ls "Total XX files in dir"
    local ordered_file_nums
    ordered_file_nums="$(/usr/bin/ls -ltr "$backup_dir" | awk 'NR>1{print $NF}')"
    local first_file
    for first_file in "${ordered_file_nums[@]}"; do
        first_file="$backup_dir/$first_file"
        echo "oldest file in dir is: $first_file"

        local current_file
        for current_file in "${ordered_file_nums[@]}"; do
            current_file="$backup_dir/$current_file"

            if [ "$first_file" != "$most_merged" ]; then
                echo "oldest file is not the correct name in $backup_dir, should be: most_merged.txt"
                echo "This often happens right after a merge failed with exit code 1"
                exit 1
            fi
            [ "$current_file" = "$most_merged" ] && continue

            /usr/bin/awk '!a[$0]++' "$most_merged" "$current_file" > "$new_result"
            echo "merged two files: $(basename "$most_merged") $(basename "$current_file") > $(basename "$new_result")"
            mv "$new_result" "$most_merged"
            echo "mv $(basename "$new_result") $(basename "$most_merged")"
            echo ""
        done
        # just loop over inner loop once
        break
    done
}


delete_old_files() {
    # delete all the tmp merge files and previous saved histories
    if [ $# -ne 1 ]; then
        echo -e "Wrong number of args passed\nNeed exactly 1 arg --> a directory\n(in backup_bash_history/delete_old_files)"
        return
    fi
    if [ ! -d "$1" ]; then
        echo -e "Input argument must be a directory\n(in backup_bash_history/delete_old_files)"
        return
    fi

    local backup_dir="$1"
    local dont_delete="$backup_dir/most_merged.txt"
    for fil in "$backup_dir"/*; do

        local filename
        filename="$backup_dir/$(basename "$fil")"
        if [ "$filename" = "$dont_delete" ]; then
            echo "SKIPPING: $filename"
            continue
        else
            echo "Removing: $filename"
            rm "$filename"
        fi
    done
}



#MAIN FUNCTION:


# PASSED IN PATH TO SPECIFIC DIRECTORY!
backup_history() {
    # always backs up the current history
    # THEN: checks if we need to merge histories

    # bash has a race condition for .bash_history: https://unix.stackexchange.com/questions/190002/how-to-protect-against-purge-of-bash-history
    # and it gets me every time
    # this doesn't solve that but combined with cron and PROMPT_COMMAND and shutdown services we can just back up often and lose less each time

    if [ $# -ne 2 ]; then
        echo -e "Wrong number of args passed\nNeed exactly 2 args --> a directory, and a file name\n(in backup_bash_history/backup_history -- is main func)"
        return
    fi
    if [ ! -d "$1" ]; then
        echo -e "Input argument must be an existing directory\n(in backup_bash_history/backup_history -- is main func)"
        return
    fi
    local backup_dir="$1"
    local last_char="${backup_dir: -1:1}"

    # remove '/' from input: backup_dir if given
    [ "$last_char" = '/' ] && backup_dir="${backup_dir:0:-1}"
    local backed_up_file="$backup_dir/$2"
    echo "$backed_up_file"

    # create a backup of bash history
    cp "$HOME/.bash_history" "$backed_up_file"
    local NUM_BACKUPS
    NUM_BACKUPS="$(ls "$backup_dir" | wc -l)"

    # default values is 20 (needed for cron jobs which dont use the env var)
    if [ "$NUM_BACKUPS" -ge "${MAX_HIST_BACKUPS:-20}" ]; then

        # don't delete backups if there was an error merging
        [ "$(merge_backup_histories "$backup_dir")" ] && delete_old_files "$backup_dir"
        # [ $? -eq 0 ] && delete_old_files "$backup_dir"
    fi
    # echo -e "-------------------- DONE: $next_backup_file ---------------------"
    echo -e "-------------------- DONE  ---------------------"
}





# ------------------------ ENTRY POINT -----------------

# TODO: move the entrypoint shit into a diff script which sources ^^^^ functions before being doing its job

OPTIONS=("--random")
# avoid errors when I just want to source the script and get access to functions
if [ $# -eq 0 ]; then
    echo "USAGE: backup_bash_history [--random] /path/to/dir"
    # exit 0
    # this is incorrect but allows script to continue executing
    # need to continue executing since all files are concatenated together
    # return
    # echo 'after return'

elif [ $# -eq 1 ]; then
    if [ ! -d "$1" ]; then
        echo -e "Input argument must be an existing directory\n(in backup_bash_history/script)"
        exit 1
    fi
    backup_dir="$1"
    backed_up_file="$(generate_file_name "$*")"
    echo "file name: $backed_up_file"
    backup_history "$backup_dir" "$backed_up_file"

elif [ $# -eq 2 ]; then
    if [ ! -d "$2" ]; then
        echo -e "Second input argument must be an existing directory\n(in backup_bash_history/script)"
        exit 1
    fi
    backup_dir="$2"

    for option in "${OPTIONS[@]}"; do
        if [ "$1" = "$option" ]; then
            if [ "$option" = '--random' ]; then
                backed_up_file="$(generate_file_name "$@")"
                echo "file name: $backed_up_file"
                backup_history "$backup_dir" "$backed_up_file"
                exit 0
            fi
        fi
    done
    # if we finish the loop then we never hit a return
    echo -e "Please use a valid option from the following list: ${OPTIONS[*]}"
fi



# dependencies: /usr/bin/awk
# env var: $MAX_HIST_BACKUPS



# ====================================================================================== #
# ====================================================================================== #
# ===============  programs/hist_save/dev/create_history_backup_dirs.sh  =============== #
# ====================================================================================== #


# ------------------- setup bash history backup directory structure fxns -------
setup_dir(){
    # mkdir a subdir if it does not exist
    # add "most_merged.txt" to subdir if it doesn't already exist
    if [ $# -ne 1 ]; then
        echo -e "Wrong number of args passed\nNeed exactly 1 args --> /path/to/dir\n(in create_history_backup_dirs.sh/setup_dir)"
        return
    fi
    local path_to_dir="$1"

    if [ ! -d "$path_to_dir" ]; then
        echo "Setup: mkdir -p $path_to_dir ..."
        mkdir -p "$path_to_dir"
    fi
    local new_file="$path_to_dir/most_merged.txt"
    if [ ! -f "$new_file" ]; then
        echo "Setup: touch $new_file ..."
        touch "$new_file"
    fi
    # echo ""
}


make_sub_directories(){
    # input: path/to/dir array of subdir names to create
    if [ ! -d "$1" ]; then
        echo -e "First input argument must be a directory,\n(in create_history_backup_dirs.sh/make_sub_directories)"
        return
    fi
    local backup_dir="$1"
    shift
    local dir_name
    for dir_name in "$@"; do
        setup_dir "$backup_dir/$dir_name"
    done
    # echo ""
}


create_root_backup_dirs() {
    # for DIR in "${DIRS[@]}"; do
    local DIR
    for DIR in "$@"; do
        create_root_backup_dir "$DIR"
    done
}


create_root_backup_dir() {
    local DIR="$1"
    [ ! -d "$DIR" ] && mkdir "$DIR" && echo "mkdir $DIR"
}


create_backup_directories(){
    # expected: $HOME
    if [ $# -ne 1 ]; then
        echo -e "Wrong number of args passed\nNeed exactly 1 arg --> a directory\n(in create_history_backup_dirs.sh/create_backup_directories)"
        return
    fi
    if [ ! -d "$1" ]; then
        echo -e "Input argument must be a directory\n(in create_history_backup_dirs.sh/create_backup_directories)"
        return
    fi
    local base_dir="$1/.history_copies"
    local scheduled="$base_dir/scheduled"
    local tmp="$base_dir/tmp"
    # DIRS=("$base_dir" "$scheduled" "$tmp")
    create_root_backup_dirs "$base_dir" "$scheduled" "$tmp"


    local sub_dirs
    sub_dirs=("hourly" "daily" "weekly" "monthly" "yearly")
    make_sub_directories "$scheduled" "${sub_dirs[@]}"

    sub_dirs=("shutdown" "random_save")
    make_sub_directories "$tmp" "${sub_dirs[@]}"
}

# main() {
# TODO: write a little test for this which shows usage
#     create_backup_directories "$HOME"
# }



# ------------------- setup bash history backup directory structure fxns -------

#     [ ! -d "$base_dir" ] && mkdir "$base_dir" && echo "mkdir $base_dir"
#     [ ! -d "$scheduled" ] && mkdir "$scheduled" && echo "mkdir $scheduled"
#     [ ! -d "$tmp" ] && mkdir "$tmp" && echo "mkdir $tmp"



# ========================================================================= #
# ========================================================================= #
# ===============  programs/hist_save/dev/setup_history.sh  =============== #
# ========================================================================= #


# export MAX_HIST_BACKUPS=20

# only needed in past to enable histappend, thats done before this !
# if [ -f $bash_dotfiles_root/shopts.sh ]; then
#     source $bash_dotfiles_root/shopts.sh
# else
#     echo "shopts.sh script is NOT in the same directory as bash dotfiles"
#     return
# fi

if [ -f "$bash_dotfiles_root/programs/hist_save/dev/create_history_backup_dirs.sh" ]; then
    source "$bash_dotfiles_root/programs/hist_save/dev/create_history_backup_dirs.sh"
    # note that nothing is done if the dirs exist
    create_backup_directories "$HOME"
else
    echo "create_history_backup_dirs.sh script is NOT in the expected location: $bash_dotfiles_root/programs/hist_save/dev"
    return
fi


# add this to prompt command !!!!!!! get extra randomness cuz only happens if we run cmd on 5th minute of an hour

# create a general file merging bash file!!!
# pass in base_dir and backup_dir arguments
# it creates a dir structure if not exists


# change so that I can hold more versions of files
# can I lock a file from being looked at by more than 1 process
#--------- use flock !!!!


# Todo: test this, meant to make it that no shell saves twice in the same minute
# export last_save_time=""

randomly_save_history() {
    local curr_time
    local time
    local every_four_mins
    curr_time="$(date +%H:%M)"
    time="$(echo $curr_time | tr -d ':' | sed 's/^0*//')"
    every_four_mins=$(($time%6))
    # if [ "$last_save_time" = "$curr_time" ]; then
    #     return
    # fi

    if [ $every_four_mins -eq 0 ]; then
        local save_history
        save_history=$((3*$every_four_mins+$RANDOM%20+$RANDOM%50))
        save_history=$(($save_history%25))

        # make more random !!!!
        if [ $save_history -eq 0 ]; then
            # export last_save_time="$curr_time"
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
# HISTIGNORE="exit:clear:pwd:mount*:umount*"

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



# ================================================================ #
# ================================================================ #
# ===============  programs/git/dev/git-prompt.sh  =============== #
# ================================================================ #


# bash/zsh git prompt support
#
# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
# Distributed under the GNU General Public License, version 2.0.
#
# This script allows you to see repository status in your prompt.
#
# To enable:
#
#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.git-prompt.sh
#    3a) Change your PS1 to call __git_ps1 as
#        command-substitution:
#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#        ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
#        the optional argument will be used as format string.
#    3b) Alternatively, for a slightly faster prompt, __git_ps1 can
#        be used for PROMPT_COMMAND in Bash or for precmd() in Zsh
#        with two parameters, <pre> and <post>, which are strings
#        you would put in $PS1 before and after the status string
#        generated by the git-prompt machinery.  e.g.
#        Bash: PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
#          will show username, at-sign, host, colon, cwd, then
#          various status string, followed by dollar and SP, as
#          your prompt.
#        ZSH:  precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
#          will show username, pipe, then various status string,
#          followed by colon, cwd, dollar and SP, as your prompt.
#        Optionally, you can supply a third argument with a printf
#        format string to finetune the output of the branch status
#
# The repository status will be displayed only if you are currently in a
# git repository. The %s token is the placeholder for the shown status.
#
# The prompt status always includes the current branch name.
#
# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
# unstaged (*) and staged (+) changes will be shown next to the branch
# name.  You can configure this per-repository with the
# bash.showDirtyState variable, which defaults to true once
# GIT_PS1_SHOWDIRTYSTATE is enabled.
#
# You can also see if currently something is stashed, by setting
# GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
# then a '$' will be shown next to the branch name.
#
# If you would like to see if there're untracked files, then you can set
# GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
# files, then a '%' will be shown next to the branch name.  You can
# configure this per-repository with the bash.showUntrackedFiles
# variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
# enabled.
#
# If you would like to see the difference between HEAD and its upstream,
# set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
# indicates you are ahead, "<>" indicates you have diverged and "="
# indicates that there is no difference. You can further control
# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
# of values:
#
#     verbose       show number of commits ahead/behind (+/-) upstream
#     name          if verbose, then also show the upstream abbrev name
#     legacy        don't use the '--count' option available in recent
#                   versions of git-rev-list
#     git           always compare HEAD to @{upstream}
#     svn           always compare HEAD to your SVN upstream
#
# You can change the separator between the branch name and the above
# state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
# is SP.
#
# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
# find one, or @{upstream} otherwise.  Once you have set
# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
# setting the bash.showUpstream config variable.
#
# If you would like to see more information about the identity of
# commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
# to one of these values:
#
#     contains      relative to newer annotated tag (v1.6.3.2~35)
#     branch        relative to newer tag or branch (master~4)
#     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#     tag           relative to any older tag (v1.6.3.1-13-gdd42c2f)
#     default       exactly matching tag
#
# If you would like a colored hint about the current dirty state, set
# GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
# the colored output of "git status -sb" and are available only when
# using __git_ps1 for PROMPT_COMMAND or precmd.
#
# If you would like __git_ps1 to do nothing in the case when the current
# directory is set up to be ignored by git, then set
# GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
# repository level by setting bash.hideIfPwdIgnored to "false".


# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1




# check whether printf supports -v
__git_printf_supports_v=
printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1

# stores the divergence from upstream in $p
# used by GIT_PS1_SHOWUPSTREAM
__git_ps1_show_upstream ()
{
	local key value
	local svn_remote svn_url_pattern count n
	local upstream=git legacy="" verbose="" name=""

	svn_remote=()
	# get some config options from git-config
	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
	while read -r key value; do
		case "$key" in
		bash.showupstream)
			GIT_PS1_SHOWUPSTREAM="$value"
			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
				p=""
				return
			fi
			;;
		svn-remote.*.url)
			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
			svn_url_pattern="$svn_url_pattern\\|$value"
			upstream=svn+git # default upstream is SVN if available, else git
			;;
		esac
	done <<< "$output"

	# parse configuration values
	for option in ${GIT_PS1_SHOWUPSTREAM}; do
		case "$option" in
		git|svn) upstream="$option" ;;
		verbose) verbose=1 ;;
		legacy)  legacy=1  ;;
		name)    name=1 ;;
		esac
	done

	# Find our upstream
	case "$upstream" in
	git)    upstream="@{upstream}" ;;
	svn*)
		# get the upstream from the "git-svn-id: ..." in a commit message
		# (git-svn uses essentially the same procedure internally)
		local -a svn_upstream
		svn_upstream=($(git log --first-parent -1 \
					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
			svn_upstream=${svn_upstream%@*}
			local n_stop="${#svn_remote[@]}"
			for ((n=1; n <= n_stop; n++)); do
				svn_upstream=${svn_upstream#${svn_remote[$n]}}
			done

			if [[ -z "$svn_upstream" ]]; then
				# default branch name for checkouts with no layout:
				upstream=${GIT_SVN_ID:-git-svn}
			else
				upstream=${svn_upstream#/}
			fi
		elif [[ "svn+git" = "$upstream" ]]; then
			upstream="@{upstream}"
		fi
		;;
	esac

	# Find how many commits we are ahead/behind our upstream
	if [[ -z "$legacy" ]]; then
		count="$(git rev-list --count --left-right \
				"$upstream"...HEAD 2>/dev/null)"
	else
		# produce equivalent output to --count for older versions of git
		local commits
		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
		then
			local commit behind=0 ahead=0
			for commit in $commits
			do
				case "$commit" in
				"<"*) ((behind++)) ;;
				*)    ((ahead++))  ;;
				esac
			done
			count="$behind	$ahead"
		else
			count=""
		fi
	fi

	# calculate the result
	if [[ -z "$verbose" ]]; then
		case "$count" in
		"") # no upstream
			p="" ;;
		"0	0") # equal to upstream
			p="=" ;;
		"0	"*) # ahead of upstream
			p=">" ;;
		*"	0") # behind upstream
			p="<" ;;
		*)	    # diverged from upstream
			p="<>" ;;
		esac
	else
		case "$count" in
		"") # no upstream
			p="" ;;
		"0	0") # equal to upstream
			p=" u=" ;;
		"0	"*) # ahead of upstream
			p=" u+${count#0	}" ;;
		*"	0") # behind upstream
			p=" u-${count%	0}" ;;
		*)	    # diverged from upstream
			p=" u+${count#*	}-${count%	*}" ;;
		esac
		if [[ -n "$count" && -n "$name" ]]; then
			__git_ps1_upstream_name=$(git rev-parse \
				--abbrev-ref "$upstream" 2>/dev/null)
			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
				p="$p \${__git_ps1_upstream_name}"
			else
				p="$p ${__git_ps1_upstream_name}"
				# not needed anymore; keep user's
				# environment clean
				unset __git_ps1_upstream_name
			fi
		fi
	fi

}

# Helper function that is meant to be called from __git_ps1.  It
# injects color codes into the appropriate gitstring variables used
# to build a gitstring.
__git_ps1_colorize_gitstring ()
{
	if [[ -n ${ZSH_VERSION-} ]]; then
		local c_red='%F{red}'
		local c_green='%F{green}'
		local c_lblue='%F{blue}'
		local c_clear='%f'
	else
		# Using \[ and \] around colors is necessary to prevent
		# issues with command line editing/browsing/completion!
		local c_red='\[\e[31m\]'
		local c_green='\[\e[32m\]'
		local c_lblue='\[\e[1;34m\]'
		local c_clear='\[\e[0m\]'
	fi
	local bad_color=$c_red
	local ok_color=$c_green
	local flags_color="$c_lblue"

	local branch_color=""
	if [ $detached = no ]; then
		branch_color="$ok_color"
	else
		branch_color="$bad_color"
	fi
	c="$branch_color$c"

	z="$c_clear$z"
	if [ "$w" = "*" ]; then
		w="$bad_color$w"
	fi
	if [ -n "$i" ]; then
		i="$ok_color$i"
	fi
	if [ -n "$s" ]; then
		s="$flags_color$s"
	fi
	if [ -n "$u" ]; then
		u="$bad_color$u"
	fi
	r="$c_clear$r"
}

# Helper function to read the first line of a file into a variable.
# __git_eread requires 2 arguments, the file path and the name of the
# variable, in that order.
__git_eread ()
{
	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
}

# see if a cherry-pick or revert is in progress, if the user has committed a
# conflict resolution with 'git commit' in the middle of a sequence of picks or
# reverts then CHERRY_PICK_HEAD/REVERT_HEAD will not exist so we have to read
# the todo file.
__git_sequencer_status ()
{
	local todo
	if test -f "$g/CHERRY_PICK_HEAD"
	then
		r="|CHERRY-PICKING"
		return 0;
	elif test -f "$g/REVERT_HEAD"
	then
		r="|REVERTING"
		return 0;
	elif __git_eread "$g/sequencer/todo" todo
	then
		case "$todo" in
		p[\ \	]|pick[\ \	]*)
			r="|CHERRY-PICKING"
			return 0
		;;
		revert[\ \	]*)
			r="|REVERTING"
			return 0
		;;
		esac
	fi
	return 1
}

# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# when called from PS1 using command substitution
# in this mode it prints text to add to bash PS1 prompt (includes branch name)
#
# __git_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
# when two arguments are given, the first is prepended and the second appended
# to the state string when assigned to PS1.
# The optional third parameter will be used as printf format string to further
# customize the output of the git-status string.
# In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
__git_ps1 ()
{
	# preserve exit status
	local exit=$?
	local pcmode=no
	local detached=no
	local ps1pc_start='\u@\h:\w '
	local ps1pc_end='\$ '
	local printf_format=' (%s)'

	case "$#" in
		2|3)	pcmode=yes
			ps1pc_start="$1"
			ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
			# set PS1 to a plain prompt so that we can
			# simply return early if the prompt should not
			# be decorated
			PS1="$ps1pc_start$ps1pc_end"
		;;
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return $exit
		;;
	esac

	# ps1_expanded:  This variable is set to 'yes' if the shell
	# subjects the value of PS1 to parameter expansion:
	#
	#   * bash does unless the promptvars option is disabled
	#   * zsh does not unless the PROMPT_SUBST option is set
	#   * POSIX shells always do
	#
	# If the shell would expand the contents of PS1 when drawing
	# the prompt, a raw ref name must not be included in PS1.
	# This protects the user from arbitrary code execution via
	# specially crafted ref names.  For example, a ref named
	# 'refs/heads/$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' might cause the
	# shell to execute 'sudo rm -rf /' when the prompt is drawn.
	#
	# Instead, the ref name should be placed in a separate global
	# variable (in the __git_ps1_* namespace to avoid colliding
	# with the user's environment) and that variable should be
	# referenced from PS1.  For example:
	#
	#     __git_ps1_foo=$(do_something_to_get_ref_name)
	#     PS1="...stuff...\${__git_ps1_foo}...stuff..."
	#
	# If the shell does not expand the contents of PS1, the raw
	# ref name must be included in PS1.
	#
	# The value of this variable is only relevant when in pcmode.
	#
	# Assume that the shell follows the POSIX specification and
	# expands PS1 unless determined otherwise.  (This is more
	# likely to be correct if the user has a non-bash, non-zsh
	# shell and safer than the alternative if the assumption is
	# incorrect.)
	#
	local ps1_expanded=yes
	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=no

	local repo_info rev_parse_exit_code
	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree \
		--short HEAD 2>/dev/null)"
	rev_parse_exit_code="$?"

	if [ -z "$repo_info" ]; then
		return $exit
	fi

	local short_sha=""
	if [ "$rev_parse_exit_code" = "0" ]; then
		short_sha="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
	fi
	local inside_worktree="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local bare_repo="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local inside_gitdir="${repo_info##*$'\n'}"
	local g="${repo_info%$'\n'*}"

	if [ "true" = "$inside_worktree" ] &&
	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
	   git check-ignore -q .
	then
		return $exit
	fi

	local r=""
	local b=""
	local step=""
	local total=""
	if [ -d "$g/rebase-merge" ]; then
		__git_eread "$g/rebase-merge/head-name" b
		__git_eread "$g/rebase-merge/msgnum" step
		__git_eread "$g/rebase-merge/end" total
		r="|REBASE"
	else
		if [ -d "$g/rebase-apply" ]; then
			__git_eread "$g/rebase-apply/next" step
			__git_eread "$g/rebase-apply/last" total
			if [ -f "$g/rebase-apply/rebasing" ]; then
				__git_eread "$g/rebase-apply/head-name" b
				r="|REBASE"
			elif [ -f "$g/rebase-apply/applying" ]; then
				r="|AM"
			else
				r="|AM/REBASE"
			fi
		elif [ -f "$g/MERGE_HEAD" ]; then
			r="|MERGING"
		elif __git_sequencer_status; then
			:
		elif [ -f "$g/BISECT_LOG" ]; then
			r="|BISECTING"
		fi

		if [ -n "$b" ]; then
			:
		elif [ -h "$g/HEAD" ]; then
			# symlink symbolic ref
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		else
			local head=""
			if ! __git_eread "$g/HEAD" head; then
				return $exit
			fi
			# is it a symbolic ref?
			b="${head#ref: }"
			if [ "$head" = "$b" ]; then
				detached=yes
				b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(tag)
					git describe --tags HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" ||

				b="$short_sha..."
				b="($b)"
			fi
		fi
	fi

	if [ -n "$step" ] && [ -n "$total" ]; then
		r="$r $step/$total"
	fi

	local w=""
	local i=""
	local s=""
	local u=""
	local c=""
	local p=""

	if [ "true" = "$inside_gitdir" ]; then
		if [ "true" = "$bare_repo" ]; then
			c="BARE:"
		else
			b="GIT_DIR!"
		fi
	elif [ "true" = "$inside_worktree" ]; then
		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
		then
			git diff --no-ext-diff --quiet || w="*"
			git diff --no-ext-diff --cached --quiet || i="+"
			if [ -z "$short_sha" ] && [ -z "$i" ]; then
				i="#"
			fi
		fi
		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
		   git rev-parse --verify --quiet refs/stash >/dev/null
		then
			s="$"
		fi

		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
		   git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
		then
			u="%${ZSH_VERSION+%}"
		fi

		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
			__git_ps1_show_upstream
		fi
	fi

	local z="${GIT_PS1_STATESEPARATOR-" "}"

	# NO color option unless in PROMPT_COMMAND mode
	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
		__git_ps1_colorize_gitstring
	fi

	b=${b##refs/heads/}
	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
		__git_ps1_branch_name=$b
		b="\${__git_ps1_branch_name}"
	fi

	local f="$w$i$s$u"
	local gitstring="$c$b${f:+$z$f}$r$p"

	if [ $pcmode = yes ]; then
		if [ "${__git_printf_supports_v-}" != yes ]; then
			gitstring=$(printf -- "$printf_format" "$gitstring")
		else
			printf -v gitstring -- "$printf_format" "$gitstring"
		fi
		PS1="$ps1pc_start$gitstring$ps1pc_end"
	else
		printf -- "$printf_format" "$gitstring"
	fi

	return $exit
}


# this allows me to only show current and parent directory!
curr_parent='${PWD#"${PWD%/*/*}/"}'

export PS1='$(__git_ps1 " \[\e[01;31m\][\[\e[m\]%s\[\e[01;31m\]]\[\e[m\]")'

export PS1="$PS1  \[\e[33m\]-\[\e[m\]  \@ \[\e[33m\]-\[\e[m\] \[\e[01;31m\][\[\e[m\]$curr_parent\[\e[01;31m\]] \[\e[m\]\[\e[32m\]\\$\[\e[m\] "




# =============================================================== #
# =============================================================== #
# ===============  programs/git/dev/old_stuff.sh  =============== #
# =============================================================== #



# -------------- Git commands --------------------------------------------------
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# lots of git bindings to look at here ^
# the forgit plugin is also sick

# remember this being annoying lol but i guess im keeping it
# Create useful gitignore files
# Usage: gi [param]
# param is a comma separated list of ignore profiles.
# If param is ommited choose interactively.

# function __gi() {
#   curl -L -s https://www.gitignore.io/api/"$@"
# }

# gi() {
#     if  [ "$#" -eq 0 ]; then
#     IFS+=","
#     for item in $(__gi list); do
#         echo $item
#     done | fzf --multi --ansi | paste -s -d "," - |
#     { read result && __gi "$result"; }
#     else
#     __gi "$@"
#     fi
# }




# ====================================================== #
# ====================================================== #
# ===============  programs/opam/dev.sh  =============== #
# ====================================================== #


# opam configuration -- ocaml
test -r /home/brendon/.opam/opam-init/init.sh && . /home/brendon/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
