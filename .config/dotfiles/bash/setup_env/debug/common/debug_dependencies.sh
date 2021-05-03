#!/usr/bin/env bash

get_prefix() {
    if [ "$#" -gt 2 ]; then
        fn_err_msg --err='Wrong number arguments' --expected='! $# -gt 2' --recieved="$*" --msg="recieved $# args" 'get_prefix' "$(basename "$0")"
        # echo 'recieved wrong number of arguments to print_first_line function'
        return 1
    fi
    # padding="${2:-"    "}"
    local have_dependencies="$1"
    local is_first_line="${2:-false}"
    local padding="    "

    if [ "$is_first_line" = true ]; then
        local not_found_prefix="$(with_color 'RED' "Missing") -> "
        local found_prefix="$(with_color 'GREEN' "Installed") -> "
    else
        local not_found_prefix="${padding}$(with_color 'RED' "NOT found: ")"
        local found_prefix="${padding}$(with_color 'GREEN' "found: ")"
    fi

    [ "$have_dependencies" = true ] && echo "$found_prefix" || echo "$not_found_prefix"
}


print_dependency_results(){
    if [ "$#" -ne 2 ]; then
        fn_err_msg --err='Wrong number arguments' --expected='! $# -ne 2' --recieved="$*" --msg="recieved $# args" 'print_dependency_results' "$(basename "$0")"
        # echo "wrong number of arguments passed to print_dependency_results, expected 2 arguments. recieved: $# arguments"
        return 1
    fi
    local have_dependencies="$1"
    local array_name="$2"
    # echo "array name: $array_name"
    local -a dependencies=("${!array_name}")
    local padding="    "

    # print_first_line "$have_dependencies"
    get_prefix "$have_dependencies" true
    # echo -e "have_deps: $have_dependencies, deps: $dependencies"

    local prefix
    for dep in "${dependencies[@]}"; do
        prefix="$(get_prefix "$have_dependencies")"
        echo "${prefix}${dep}"
    done
    echo ''

}


# nice for individually wrapping a function with its dependencies
# old: if  hash ps > /dev/null 2>&1 && hash sort /dev/null 2>&1 && hash head /dev/null 2>&1; then
# new: if have_dependencies 'ps' 'sort' 'head'; then
have_dependencies() {
    # input: whitespace delimited names of dependencies
    # output:
    #   two color coded lists of installed and missing dependencies from input list
    if [ $# -le 0 ]; then
        fn_err_msg --err='Wrong number arguments' -e='! $# -le 0' -r="$*" --msg='no dependencies to analyze' 'have_dependencies' "$(basename "$0")"
        # echo 'Argument Error: no dependencies to analyze in have_dependencies function'
        return 1
    fi
    declare -a not_found=()
    declare -a found=()
    for dep in "$@"; do
        if ! hash "$dep" > /dev/null 2>&1; then
            # don't print right away so we can print all not_found grouped together
            not_found+=("$dep")
        else
            found+=("$dep")
        fi
    done

    # don't print anything if we have all the dependencies
    if [ "${#not_found[@]}" -ne 0 ]; then
        echo ""
        print_dependency_results true 'found[@]'
        print_dependency_results false 'not_found[@]'
        return 1
    fi
    return 0
}



a_test(){
    source ../colors/minimal/8-16_compat.sh > /dev/null
    source ./func_call_err.sh
    have_dependencies 'bat' 'madeup' 'other' 'hash'
    # have_dependencies 'bat' 'hash'
}
