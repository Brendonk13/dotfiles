#!/usr/bin/env bash

help_msg() {
    local USAGE='fn_err_msg [--option=value] function_name script_name'
    local OPTIONS='[-h|--help] [--err=] [-e|--expected=] [-r|--received] [--msg]'

    local option_prefix="  $(with_color 'WHITE' 'Action:')"
    local option_color='CYAN'

    echo -e "USAGE of $(pprint_function_name 'fn_err_msg')"
    echo -e "    $(with_color 'YELLOW_B' "->") $USAGE\n"

    echo -e "${__COLORs[WHITE_B]}Options: $(with_color 'WHITE' "$OPTIONS\n")"

    echo -e "$(with_color "$option_color" "-h, --help")"
    echo -e "${option_prefix} Print help message\n"

    echo -e "$(with_color "$option_color" "--err='error name'")"
    echo -e "${option_prefix} Set the type of error. $(with_color 'CYAN_B' "ie:") fn_err_msg --err='Number arguments'\n"

    echo -e "$(with_color "$option_color" "--expected='123'")"
    echo -e "${option_prefix} Print value expected\n"

    echo -e "$(with_color "$option_color" "--received='1'")"
    echo -e "${option_prefix} Print value received\n"

    echo -e "$(with_color "$option_color" "--msg='some helpful message'")"
    echo -e "${option_prefix} Print helpful message at the end of err msg, ie: 'positional Argument 3: 'file_name' is not a file'\n"
}


fn_err_msg() {
    # USAGE='fn_err_msg [--option=value] function_name script_name'
    # OPTIONS='[-h|--help] [--err=] [-e|--expected=] [-r|--received] [--msg]'

    # check that the user entered at least two arguments
    # note the exception is when --help flag is passed
    if [ "$#" -lt 2 ]; then
        if [[ ! "$1" =~ ^(-h|--help)$ ]]; then
            # echo 'less than 2 args'

            # always show help when function called incorrectly
            # maybe this means that the inner cond should be: help_msg && [[ ! =~ --help ]] && fn_err_msg --err='Less than 2 args received', ...; return
            help_msg
            fn_err_msg --err='Less than 2 args received' --received="$*" 'fn_err_msg' "$(basename "$0")"
            return
        fi
    fi

    # extract user input
    declare -A INPUTS
    while test $# -gt 0; do
        case "$1" in
            -h|--help)      help_msg; exit 0 ;;
            --err*)         INPUTS[err_type]="${1#*=}"; shift ;;
            -e|--expected*) INPUTS[expected]="${1#*=}"; shift ;;
            -r|--received*) INPUTS[received]="${1#*=}"; shift ;;
            --msg*)         INPUTS[msg]="${1#*=}"     ; shift ;;
            *)
                if [ $# -gt 2 ]; then
                    fn_err_msg --msg='maybe a mispelling' --err='Unknown argument' --received="$1" --expected="A valid parameter"  'fn_err_msg' "$(basename "$0")"
                    return 1
                # grab the only positional args which are after --options
                elif [ $# -eq 2 ]; then
                    INPUTS[fxn_name]="$1"; shift
                elif [ $# -eq 1 ]; then
                    INPUTS[script_name]="$1"; shift
                else
                    break
                fi
              ;;
        esac
    done

    # function which extracts data from inputs and calls everything in order so it looks pretty
    print_in_order INPUTS
}


print_in_order() {
    local -n data="$1"

    local function_name="${data[fxn_name]}"
    local script_name="${data[script_name]}"

    local err_type="${data[err_type]}"
    local expected="${data[expected]}"
    local received="${data[received]}"
    local msg="${data[msg]}"

    # echo "function_name: $function_name"
    # echo "script_name: $script_name"
    # echo "err_type: $err_type"
    # echo "expected: $expected"
    # echo "received: $received"

    local padding='    '

    pprint_script_name "$script_name"

    if [ -n "$err_type" ]; then
        pprint_err_and_function "'$err_type'" "$function_name"
    else
        pprint_function_name "$function_name"
    fi
    [ -n "$expected" ] && pprint_expected "$expected"
    [ -n "$received" ] && pprint_received "$received"
    [ -n "$msg" ] && pprint_message "$msg"
    echo ""
}

pprint_script_name() {
    local script_name="$1"
    # echo -e "------------- with_color white $(with_color 'WHITE' "${script_name}")"
    echo -e "${__COLORs[CYAN_B]}File: $(with_color 'WHITE' "${script_name}") ${__COLORs[NOCOL]}"
}


pprint_function_name() {
    local function_name="$1"
    local first_part="$(with_color 'YELLOW_B' "function: ")"
    local second_part="$(with_color 'YELLOW' "${function_name}")"
    echo -e "${first_part}${second_part}"
}


pprint_err_and_function() {
    local err_type="$1"
    local function_name="$2"
    # padding="${3:-"    "}"
    local padding="${3:-""}"
    echo -e "${padding}$(with_color 'RED_B' "ERROR ->") $(with_color 'RED' "${err_type}") encountered in $(pprint_function_name "$function_name")"
}


pprint_expected() {
    local expected="$1"
    local padding="${2:-"    "}"
    local first_part="$(with_color 'GREEN_B' "${padding}Expected: ")"
    local second_part="$(with_color 'GREEN' "$expected")"
    echo -e "${first_part}${second_part}"
}


pprint_received() {
    local received="$1"
    local padding="${2:-"    "}"
    local first_part="$(with_color 'RED_B' "${padding}Received: ")"
    local second_part="$(with_color 'RED' "$received")"
    echo -e "${first_part}${second_part}"
}

pprint_message() {
    local msg="$1"
    local padding="${3:-"    "}"
    local first_part="$(with_color 'WHITE_B' "${padding}Error message: ")"
    local second_part="$(with_color 'WHITE' "'$msg'")"
    echo -e "${first_part}${second_part}"
}


# color_section(){
#     color="$1"
#     section="$2"
#     echo -e "${color}$section${__COLORs[NOCOL]}"
# }
