#!/usr/bin/env bash

# Todo: add fzf to search thru 'scripts' in package.json!!



[ -f "$XDG_CONFIG_HOME/dotfiles/bash/from_online.sh" ] && source "$XDG_CONFIG_HOME/dotfiles/bash/from_online.sh"

function changeDirAndShow() {
    cd "$1" && ls -A
}


# follow moved files to the dest. folder
function mcd() {
    if [ "$#" -lt 2 ]; then
        echo "Input files and destination for this to work jeez."
        echo "Next time enter more than 1 argument: mcd files dest."
        return
    fi
    file_destination=${@:$#}
    num_files=$#

    # num_files is originally counting files and the destination dir
    # so shift one less time than $#
    num_files=$(($num_files - 1))

    while [ "$num_files" -gt 0 ]; do
        mv "$1" "$file_destination"
        num_files=$(($num_files - 1))
        shift
    done

    echo "";  echo " ----- DESTINATION DIR CONTENTS:";
    cd "$file_destination"
    if hash lsd > /dev/null 2>&1; then
        lsd --group-dirs first
    else
        ls --group-directories --color
    fi
    echo ""
}


cht() {
    paste the general cheat sheet curl cmd in terminal
    echo 'use: cht.sh/java/"question"'
    echo -n 'curl cht.sh/ /"for loop"' | xclip -selection c
    echo 'just enter this command for way more cheat sheet info !!'
    sleep 0.1
    if hash xdotool > /dev/null 2>&1; then
        xdotool key ctrl+shift+v
    fi
}


# fuzzy search arch/AUR repositories then download
function search_packages() {
    pac_manager="$1"
    if [ "$pac_manager" == "yay" ]; then
        # "$pac_manager" -S --noconfirm "$package_name"
        yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S --noconfirm
        # sudo not recommended for yay installs
    else
        pacman -Slq  | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S --noconfirm
    #     sudo "$pac_manager" -S --noconfirm "$package_name"
    fi
}


# get line count of files, pass in arg to recurse into directories :)
function lines_in_dir() {
    help="USAGE:\tlines filetype [recurse-depth]\ndefault depth is 1"
    if [ "$#" -lt 1 ]; then
        echo -e "$help"
        return
    fi
    filetype="$1"
    files=""
    if [ "$#" -eq 1 ]; then
        files=$(find . -maxdepth 1 -type f -name "*.$filetype")
    elif [ "$#" -eq 2 ]; then
        files=$(find . -maxdepth $2 -type f -name "*.$filetype")
    fi

    if [ "$files" = "" ]; then
        echo "No files with extension: .$filetype found at given depth"
        return
    else
        echo "$files" | wc -l `awk '{print $1}'`
    fi
}
# alias lines=lines_in_dir


# -------------- Git commands --------------------------------------------------
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# lots of git bindings to look at here ^
# the forgit plugin is also sick

# showMergeConflicts() {
#     rg --count --multiline '(<<<|===|>>>)+.*$(\n.*?)+(<<<|===|>>>)+.*\n'
# }

# search through all branches and merge entered selection
fuzzyMerge() {
    # search for all merge conflicts upon merge, display conflicts if there are any
    git branch -a | fzf | awk '{print $NF}' | xargs git merge || git mergetool #showMergeConflicts
}
# alias merg=fuzzyMerge


# search through all branches and check it out
fuzzySwitchBranch() {
    git branch -a | fzf | awk '{print $NF}' | xargs git checkout
}
# alias co=fuzzySwitchBranch


fuzzyDeleteBranch() {
    # last column is the name we are looking for
    chosen_branch="$(git branch -a | fzf | awk '{print $NF}')"
    [[ "$chosen_branch" = "" ]] && return

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
# alias gbd=fuzzyDeleteBranch


# this will just push to origin current_branch
pushCurrentBranch() {
    # extract name of current branch from output, here first column is *
    current_branch="$(git branch -a | awk '{if ($1 ~ /\*/) print $NF}')"
    git push origin "$current_branch"
}
# alias gpush=pushCurrentBranch

# pull from current branch
pullCurrentBranch() {
    current_branch="$(git branch -a | awk '{if ($1 ~ /\*/) print $NF}')"
    git pull origin "$current_branch"
}
# alias gpull=pullCurrentBranch

# ------------------------------- Search For input in "fasd -Rfl" file list or from $PWD----------------------------
alias sf=ssf
ssf() {
    rg_command='rg --column --line-number --no-heading --fixed-strings --color "always"'
    search=""
    printf -v search "%q" "$*"
    if [ $# -lt 1 ]; then
        recents="$(fasd -Rfl "$1")"
        fils="$(echo -e $recents | awk '!/(^.*\.mp4$)/{print}')"
        files=`eval $rg_command $search "{$fils[*]}" | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
    else
        files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
    fi

    [[ -n "$files" ]] && $VISUAL "$files"
}


# open any previously opened mp4,png,pdf,pptx,jpg,jpeg,gif
# detaches process from parent, ie can close terminal which opened the file
alias o=fuzzy_xdgopen
fuzzy_xdgopen() {
    [ $# -gt 0 ] && fasd -f "$*" | xargs -0 setsid xdg-open && return
    local file
    # setsid opens the file in a new session so the process will survive the parent process.
    file="$(fasd -Rfl | awk '/(^.*(\.mp4|\.png|\.pdf|\.pptx|\.jpg|\.jpeg|\.gif)$)/{print}' | fzf -1 -0 --no-sort +m)" && setsid xdg-open "${file}"
}
[ -f "$HOME/.config/.fzf_setup.sh" ] && source "$HOME/.config/.fzf_setup.sh"





#think best solution is to just loop over both out, lss at same time 
# and concat each pair ala python zip printing as I go :(

#full_info_ls() {
#    # info="$(lsd --group-dirs first -l --total-size | awk '{print $11}' | xargs file)"
#    declare -a ls_output
#    ls_output="$(lsd --group-dirs first -l --total-size --blocks size,name)"
#    info="$(echo -e $ls_output awk '{print $3}' | xargs file)"
#    for ls_out in "${ls_output[@]}"; do
#    done
#    #-l --blocks size,name'
#}
# out="$(lss | awk '{print $3}' | xargs file | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}')"
# lmerge <(echo -e "$out") <(lsd -l --blocks size,name) | head | paste - -

