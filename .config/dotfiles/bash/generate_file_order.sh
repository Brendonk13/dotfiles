#!/usr/bin/env bash


store_shell_scripts(){
    local tmp
    # get all shell scripts, store as array: FILES
    # tmp="$(find . -type f -exec bash -c ' [[ "$( file -bi "$1" )" == */x-shellscript* ]]' bash {} \; -print)"
    tmp="$(find "$bash_dotfiles_root" -type f -exec bash -c ' [[ "$( file -bi "$1" )" == */x-shellscript* ]]' bash {} \; -print)"
    readarray -t FILES <<<"$tmp"

    for ff in "${FILES[@]}"; do
        # don't add shell scripts in current directory
        [ "$(dirname "$bash_dotfiles_root")" = "$(dirname "$ff")" ] && continue
        # don't add stuff under subdir: none
        [[ $ff =~ .*none.* ]] && continue
        [[ $ff =~ .*sourced.* ]] && continue
        [[ $ff =~ .*metafiles.* ]] && continue
        good_sh_files+=($ff)
        # echo $ff
    done
}

is_compatible_OS(){
    local path="$1"
    if ! [[ $path =~ $OPERATINGSYSTEM ]]; then
        [ "$OUT_NAME" = 'debug' ] && echo "  SKIPPING: $path"
        return 1
    fi
    return 0
}

add_to_correct_role_array(){
    local role="$1"
    local file="$2"
    case "$role" in
        minimal) minimal_files+=("$file") ;;
        common)  common_files+=("$file") ;;
        dev)     dev_files+=("$file") ;;
        desktop) desktop_files+=("$file") ;;
    esac
}

# NOTE: can just delete this case and declare all at the same time
init_role_array(){
    # multidimensional array hack
    # better would be to set tmp=minimal_files (etc) here and then just always add to tmp in next case
    minimal_files=()
    common_files=()
    dev_files=()
    desktop_files=()
}

add_role_array_to_dict(){
    local role="$1"
    [ "$OUT_NAME" = 'debug' ] && echo "==================== $role ========================"
    case "$role" in
        minimal) files_in_role["$role"]=minimal_files[@] ;;
        common)  files_in_role["$role"]=common_files[@] ;;
        dev)     files_in_role["$role"]=dev_files[@] ;;
        desktop) files_in_role["$role"]=desktop_files[@] ;;
    esac
    # printf '%s\n' "${!files_in_role["$role"]}"
}


init_dir_ordered_array(){
    debug_files=()
    export_files=()
    alias_files=()
    shopt_files=()
    sourced_files=()
    other_files=()
}


print_non_empty_role_files(){
     [ "${#debug_files[@]}" -gt 0 ]   && printf '%s\n' "${debug_files[@]}"
     [ "${#export_files[@]}" -gt 0 ]  && printf '%s\n' "${export_files[@]}"
     [ "${#alias_files[@]}" -gt 0 ]   && printf '%s\n' "${alias_files[@]}"
     [ "${#shopt_files[@]}" -gt 0 ]   && printf '%s\n' "${shopt_files[@]}"
     [ "${#sourced_files[@]}" -gt 0 ] && printf '%s\n' "${sourced_files[@]}"
     [ "${#other_files[@]}" -gt 0 ]   && printf '%s\n' "${other_files[@]}"
}


add_to_dir_array(){
    local DIR="$1"
    local FILE="$2"
    case "$DIR" in
        debug)   debug_files+=("$FILE")   ;;
        export)  export_files+=("$FILE")  ;;
        alias)   alias_files+=("$FILE")   ;;
        shopt)   shopt_files+=("$FILE")   ;;
        source)  sourced_files+=("$FILE") ;;
        other)   other_files+=("$FILE")   ;;
    esac
}


order_role_files(){
    init_dir_ordered_array
    local role="$1"
    for role_file in "${!files_in_role["$role"]}"; do
        case "$role_file" in
            *debug*)   add_to_dir_array 'debug'  "$role_file" ;;
            *export*)  add_to_dir_array 'export' "$role_file" ;;
            *alias*)   add_to_dir_array 'alias'  "$role_file" ;;
            *shopt*)   add_to_dir_array 'shopt'  "$role_file" ;;
            *source*)  add_to_dir_array 'source' "$role_file" ;;
            *)         add_to_dir_array 'other'  "$role_file" ;;
        esac
    done
    print_non_empty_role_files
}




generate_file_order(){
    # main function !!

    store_shell_scripts
    init_role_array
    declare -a role_order=('minimal' 'common' 'dev' 'desktop')
    for role in "${role_order[@]}"; do
        for f in "${good_sh_files[@]}"; do
            case "$f" in
                *machine_specific*)
                    continue ;;
                *$role*os_specific*)
                    is_compatible_OS $f && add_to_correct_role_array "$role" "$f" ;;
                *os_specific*$role*)
                    is_compatible_OS $f && add_to_correct_role_array "$role" "$f" ;;
                *${role}*)
                    add_to_correct_role_array "$role" "$f" ;;
                # *) echo "BAD path doesn't have role in path -> 
                # maybe add a check to see that every file made it into SOME role
                # maybe this should just be python test !
            esac
        done

        add_role_array_to_dict "$role"
        order_role_files "$role"
        [ "$role" = "$LAST_ROLE" ] && break
        # echo "done $role, last_role: $LAST_ROLE"
    done
}

source_all_files(){
    local files="$1"

    local fil
    while IFS="" read -r fil || [ -n "$fil" ]
    do
        printf '%s\n' "$fil"
        if [ -f "$fil" ]; then
            base_name="$(basename "$fil")"
            [ "$base_name" = 'backup_bash_history' ] && continue
            source "$fil"
        else
            echo "file: $(with_color 'white_b' "$file") is NOT a file"
        fi
    done < "$files"
}

setup_vars(){
    if [ -z "$bash_dotfiles_root" ]; then
        local SCRIPT_DIR
        SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
        source "$SCRIPT_DIR"/export_dotfiles_root.sh
    fi


    source "$bash_dotfiles_root"/setup_env/debug/colors/minimal/8-16_compat.sh
    [ -f "$bash_dotfiles_root"/setup_env/debug/common/func_call_err.sh ] && source "$bash_dotfiles_root"/setup_env/debug/common/func_call_err.sh

    # declare -a good_sh_files
    good_sh_files=()
    files_in_role=()
    # declare -A files_in_role

    # Todo: read this value from file in meta/data, placed there by me or ansible
    OPERATINGSYSTEM='arch_based'
    # LAST_ROLE='desktop'
    LAST_ROLE="$(cat "$bash_dotfiles_root/meta/data/last_role.txt")"
    # OUT_NAME='debug'
    OUT_NAME="$bash_dotfiles_root/meta/data/ordered_concatenated_files.txt"
    # OUT_NAME="$bash_dotfiles_root/files.txt"
}




# ================= ENTRYPOINT FUNCTIONS =======================================
gen_files(){
    setup_vars
    # OUT_NAME, LAST_ROLE overwritten if args passed to gen_files

    local dont_set_last_role
    while test $# -gt 0; do
        case "$1" in
            --help)
                echo -e "USAGE: gen_files [-o|--out-file /path/to/name.txt] [-r|--role Valid-Role] [--dont-set-last-role]
                Valid Roles:
                    -> minimal, common, dev, desktop"
                return 0 ;;
            -r|--role)
                LAST_ROLE="$2"
                shift; shift ;;
            -o|--out-file)
                OUT_NAME="$2"
                shift; shift ;;
            *)
                shift ;;
        esac
    done
    echo "from command line: LAST_ROLE = $LAST_ROLE,   OUT_NAME = $OUT_NAME"

    if [ "$OUT_NAME" = 'debug' ]; then
        generate_file_order
    else
        generate_file_order > "$OUT_NAME"
        echo "saved output to: $(with_color 'white_b' "$OUT_NAME")"
    fi
}

src_files(){
    OUT_NAME="$HOME/new_dotfiles/bash/files.txt"
    # OUT_NAME="$bash_dotfiles_root/meta/data/ordered_concatenated_files.txt"
    source_all_files "$OUT_NAME"
}

