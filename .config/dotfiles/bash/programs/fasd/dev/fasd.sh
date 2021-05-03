#!/usr/bin/env bash

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
