#!/usr/bin/env bash

# ctest ie compiler test
alias ctest=test_mode
test_mode() {
    instructions="Setup: export comp=full_path_to_src_dir
    source this script in .bashrc
    USAGE: [test_mode | ctest] [scan | parse | pretty | typecheck | symbol]"

    [[ "$#" -ne 1 ]] && echo -e "$instructions" && return
    mode="$1"

    # echo -e "$instructions"
    # ---------------- setup some vars ------------------------------
    GREEN='\033[1;32m'
    RED='\033[0;31m'
    NOCOL='\033[0m'
    fail_prefix="${RED}FAILED: ${NOCOL}"
    success="${GREEN}SUCCESS: ${NOCOL}"

    all_fails="${RED}All Failures ${NOCOL} -> "
    all_passes="${GREEN}Successes ${NOCOL} -> "


    # we write last output to this file then delete it at the end of the fxn
    last_output="$PWD/last_output.txt"

    # note: need to make a environment variable called comp
    # must be set to directory above src since i use this env var for other things
    prog_dir="$comp/../programs-solution/1-scan+parse/valid"

    # ---------------- compile files in dir according to $mode ------------------------------

    for filename in $prog_dir/*.go; do
        # extract everything after last '/' in $filename
        name="$(echo $filename | rev | cut -d/ -f1 | rev)"

        "$comp/main.native" "$mode" "$filename" &>"$last_output"

        # if the last command ran successfully, let the ppl know.
        # but don't show them the output, they might get too high on their horse
        if [ $? -eq 0 ]; then
            echo -e "$success $name"
            all_passes="$all_passes, $name"
        else
            # the last command had exit code != 0
            echo -e "$fail_prefix $name"

            # display the output of compiler mode upon failure.
            cat "$last_output"
            all_fails="$all_fails, $name"
            echo ""
        fi
    done

    # uncomment to see all programs which passed
    # echo -e "$all_passes"
    echo -e "$all_fails"
    YELLOW='\033[1;33m'
    echo -e "${YELLOW}Mode tested: $mode ${NOCOL}"
    # rm tmp file
    rm "$last_output"
}
