#!/usr/bin/env bash




# ============================================================================== #
# ============================================================================== #
# ===============  setup_env/debug/common/test_func_call_err.sh  =============== #
# ============================================================================== #


should_pass() {
    fn_err_msg --err='big error' --expected='123' --received='1' 'test_func' "$(basename $0)"
    # echo "call made:  fn_err_msg --err='big error' 'test_script' '$(basename $0)'"
}


should_fail() {
    fn_err_msg --msg='this is why the error happened' --err='big error' --expected='123' --recieved='1' 'test_func' "$(basename $0)"
    fn_err_msg 
    # mispelling of recieved
}



perform_tests(){
    source ../colors/minimal/8-16_compat.sh > /dev/null
    source ./func_call_err.sh

    echo -e "$(with_color 'RED_B' "---------- FAIL tests ---------------")"
    should_fail
    echo -e "$(with_color 'GREEN_B' "---------- PASS tests -----------------------")"
    should_pass
}

# __cleanup_env_of_COLORs



# ============================================================================== #
# ============================================================================== #
# ===============  setup_env/debug/common/debug_dependencies.sh  =============== #
# ============================================================================== #


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



# ========================================================================= #
# ========================================================================= #
# ===============  setup_env/debug/common/func_call_err.sh  =============== #
# ========================================================================= #


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



# ==================================================================== #
# ==================================================================== #
# ===============  setup_env/exports/common/common.sh  =============== #
# ==================================================================== #


export XDG_CONFIG_HOME="$HOME/.config"




# ================================================================= #
# ================================================================= #
# ===============  programs/nvim/common/exports.sh  =============== #
# ================================================================= #


if hash nvim > /dev/null 2>&1; then
    export MANPAGER='nvim +Man!'
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR=$VISUAL



# =========================================================== #
# =========================================================== #
# ===============  setup_env/alias/common.sh  =============== #
# =========================================================== #


# source ../debug/common/debug_dependencies.sh

# if  hash ps > /dev/null 2>&1 && hash sort /dev/null 2>&1 && hash head /dev/null 2>&1; then
if have_dependencies 'ps' 'sort' 'head'; then
    # show top 5 pid's according to cpu usage
    alias badproc='ps aux | sort -rk 3,3 | head -n 5'
fi

alias vim="$VISUAL"
alias vi="$VISUAL"


if hash python3 > /dev/null 2>&1; then
    # mnemonic: Run Python
    # alias rpy='python3'
    alias p='python3'
elif hash python > /dev/null 2>&1; then
    alias p='python'
    echo 'python3 not found, p=python2 alias set instead'
else
    echo 'no python found on this machine at all'
fi

alias dmesg='dmesg -TL'


# -------------- CORRECT TYPOS -------------------------------------------------

# mnemonic: Add Sudo
# alias as='sudo $(history -p !!)'
alias as='sudo !!'




# ============================================================ #
# ============================================================ #
# ===============  setup_env/shopts/common.sh  =============== #
# ============================================================ #


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# gotta have tab complete
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# append to histfile, instead of overwriting
shopt -s histappend

# store multiline commands as one history entry
shopt -s cmdhist

# before: ls *(*txt|*sh) does NOT work
# Can now do advanced pattern matching: http://mywiki.wooledge.org/glob#extglob
shopt -s extglob




# ================================================================================= #
# ================================================================================= #
# ===============  programs/built_ins/common/light_dependencies.sh  =============== #
# ================================================================================= #

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



# ===================================================================== #
# ===================================================================== #
# ===============  programs/built_ins/common/common.sh  =============== #
# ===================================================================== #



# mv
renameSameFiletype() {
    # mv wrapper, behaves the same in all but 1 case
    # if $1 has a ft and $2 does not (AND $# == 2)
    # then the second arg gets the ft of $1
    if [ $# -lt 2 ]; then
        echo "USAGE: mv file1.txt file2"
        return 1
    fi
    if [ $# -eq 2 ]; then
        local arg_with_ft="$1"
        local new_name="$2"
        if [ -f "$arg_with_ft" ] && [[ "$arg_with_ft" == *.* ]]; then
            if [[ "$new_name" != *.* ]]; then
                # if $new_name already has a filetype, don't change it (mimic 'mv' behaviour)
                if [ ! -d "$new_name" ]; then
                    # We don't want to append $ft to $new_name if it is a dir !
                    local ft="${arg_with_ft#*.}"
                    new_name="${new_name%%.*}.${ft}"
                    echo -e "$(with_color 'cyan' "new name:") $new_name"
                    \mv "$arg_with_ft" "$new_name"
                    return 0
                fi
            fi
        fi
    fi
    # echo 'normal mv'
    \mv "$@"
    # echo "mv $@"
}
# mvf: move file (not meant for dirs so appropiate)
alias mv=renameSameFiletype

function cd() {
    if [ "$#" = 0 ]; then
        pushd "$HOME" > /dev/null
    elif [ -f "$1" ]; then
        "$EDITOR" "$1"
    else
        pushd "$1" > /dev/null
    fi
}

# mnemonic back directory
# can provide a count
function bd() {
    if [ "$#" = 0 ]; then
        popd "$HOME" > /dev/null
    else
        for i in "$(seq ${1})"
        do
            popd "$1" > /dev/null
        done
    fi
}


# Usage: mark @name   -- create a bookmark
#        cd   @name   -- cd to bookmark
#        cd   @tab    -- list bookmarks
#        cd   @n<tab> -- complete with bookmark name
#        cd   @name/<tab> -- complete with subdirectory name

# CDPATH is a path of directories for cd to suggest you move to
export CDPATH=.:~/.marks
function mark() {
    ln -sr "$(pwd)" "~/.marks/$1"
}




# ============================================================ #
# ============================================================ #
# ===============  programs/extract/common.sh  =============== #
# ============================================================ #



#----------------------------- Universal zip extracter ----------------------------------------------
function extract () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xvjf "$1"    > /dev/null 2>&1 ;;
      *.tar.gz)    tar xvzf "$1"    > /dev/null 2>&1 ;;
      *.tar.xz)    tar Jxvf "$1"    > /dev/null 2>&1 ;;
      *.bz2)       bunzip2 "$1"     > /dev/null 2>&1 ;;
      *.rar)       rar x "$1"       > /dev/null 2>&1 ;;
      *.gz)        gunzip "$1"      > /dev/null 2>&1 ;;
      *.tar)       tar xvf "$1"     > /dev/null 2>&1 ;;
      *.tbz2)      tar xvjf "$1"    > /dev/null 2>&1 ;;
      *.tgz)       tar xvzf "$1"    > /dev/null 2>&1 ;;
      *.zip)       unzip -d `echo "$1" | sed 's/\(.*\)\.zip/\1/'` "$1" > /dev/null 2>&1 ;;
      *.Z)         uncompress "$1"  > /dev/null 2>&1 ;;
      *.7z)        7z x "$1"        > /dev/null 2>&1 ;;
      *)           echo "don't know how to extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}





# ================================================================== #
# ================================================================== #
# ===============  programs/git/common/functions.sh  =============== #
# ================================================================== #


# this will just push to origin current_branch
pushCurrentBranch() {
    # extract name of current branch from output, here first column is *
    local current_branch
    current_branch="$(git branch -a | awk '{if ($1 ~ /\*/) print $NF}')"
    git push origin "$current_branch"
}
alias gpush=pushCurrentBranch


# pull from current branch
pullCurrentBranch() {
    local current_branch
    current_branch="$(git branch -a | awk '{if ($1 ~ /\*/) print $NF}')"
    git pull origin "$current_branch"
}
alias gpull=pullCurrentBranch

