#!/usr/bin/env bash
# ../../../bash/built_ins/common/common.sh

# source ../../debug/colors/8-16_compat.sh > /dev/null
# source ../../debug/common/debug_dependencies.sh

if have_dependencies 'awk' 'find'; then
    # get line count of files, pass in arg to recurse into directories :)
    function lines_in_dir() {
        local help="USAGE:\tlines filetype [recurse-depth]\ndefault depth is 1"
        if [ "$#" -lt 1 ]; then
            echo -e "$help"
            return
        fi
        local filetype="$1"
        local files=""
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
    alias lines=lines_in_dir
fi
