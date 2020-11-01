#!/usr/bin/env bash

# ------------------- setup bash history backup directory structure fxns -------
setup_dir(){
    # mkdir a subdir if it does not exist
    # add "most_merged.txt" to subdir if it doesn't already exist
    if [ $# -ne 1 ]; then
        echo -e "Wrong number of args passed\nNeed exactly 1 args --> /path/to/dir\n(in create_history_backup_dirs.sh/setup_dir)"
        return
    fi
    path_to_dir="$1"

    if [ ! -d "$path_to_dir" ]; then
        echo "Setup: mkdir -p $path_to_dir ..."
        mkdir -p "$path_to_dir"
    fi
    new_file="$path_to_dir/most_merged.txt"
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
    backup_dir="$1"
    shift
    for dir_name in "$@"; do
        setup_dir "$backup_dir/$dir_name"
    done
    # echo ""
}

create_root_backup_dirs() {
    # for DIR in "${DIRS[@]}"; do
    for DIR in "$@"; do
        create_root_backup_dir "$DIR"
    done
}

create_root_backup_dir() {
    DIR="$1"
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
    base_dir="$1/.history_copies"
    scheduled="$base_dir/scheduled"
    tmp="$base_dir/tmp"
    # DIRS=("$base_dir" "$scheduled" "$tmp")
    create_root_backup_dirs "$base_dir" "$scheduled" "$tmp"


    sub_dirs=("hourly" "daily" "weekly" "monthly" "yearly")
    make_sub_directories "$scheduled" "${sub_dirs[@]}"

    sub_dirs=("shutdown" "random_save")
    make_sub_directories "$tmp" "${sub_dirs[@]}"
}
# ------------------- setup bash history backup directory structure fxns -------

#     [ ! -d "$base_dir" ] && mkdir "$base_dir" && echo "mkdir $base_dir"
#     [ ! -d "$scheduled" ] && mkdir "$scheduled" && echo "mkdir $scheduled"
#     [ ! -d "$tmp" ] && mkdir "$tmp" && echo "mkdir $tmp"
