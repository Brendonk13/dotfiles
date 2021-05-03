#!/usr/bin/env bash
# ../../../bash/built_ins/minimal/minimal.sh

storeCurrentDirectory() {
    D="$(pwd)"
}
alias cpd=storeCurrentDirectory


# follow moved files to the dest. folder
function mcd() {
    if [ "$#" -lt 2 ]; then
        echo "Input files and destination for this to work jeez."
        echo "Next time enter more than 1 argument: mcd files dest."
        return
    fi
    local file_destination=${@:$#}
    local num_files=$#

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


changeft() {
    echo "better mv file.{old_ft,new_ft}"
    if [ $# -lt 2 ]; then
        echo "USAGE: chgft *.txt ft"
        return
    fi
    local FT=${@:$#}
    local num_files=$#

    # num_files is originally counting files and the destination dir
    # so shift one less time than $#
    num_files=$(($num_files - 1))

    local new_name
    local old_name
    while [ "$num_files" -gt 0 ]; do
        old_name="$1"
        new_name="${old_name%%.*}.${FT}"
        echo "new name: $new_name"
        num_files=$(($num_files - 1))
        # mv "$old_name" "$new_name"
        shift
    done
}
alias cft=changeft


# moves up $1 directories
function up() {
  local times=$1
  while [ "$times" -gt "0" ]; do
    cd ..
    times=$(($times - 1))
  done
}


# function changeDirAndShow() {
#     cd "$1" && ls -A
# }
# alias cdl=changeDirAndShow
# alias cdl..='cdl ..'
