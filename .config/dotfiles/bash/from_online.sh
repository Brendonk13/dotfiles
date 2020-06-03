#!/usr/bin/env bash

# HSTR configuration - add this to ~/.bashrc
#alias hh=hstr                    # hh to be alias for hstr
#export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)

# moves up $1 directories
function up() {
  times=$1
  while [ "$times" -gt "0" ]; do
    cd ..
    times=$(($times - 1))
  done
}

# Create useful gitignore files
# Usage: gi [param]
# param is a comma separated list of ignore profiles.
# If param is ommited choose interactively.

# function __gi() {
#   curl -L -s https://www.gitignore.io/api/"$@"
# }

# gi() {
#     if  [ "$#" -eq 0 ]; then
#     IFS+=","
#     for item in $(__gi list); do
#         echo $item
#     done | fzf --multi --ansi | paste -s -d "," - |
#     { read result && __gi "$result"; }
#     else
#     __gi "$@"
#     fi
# }



fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  eval "$(fasd --init auto)"
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
_fasd_bash_hook_cmd_complete v m j o zz


# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
v() {
    [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $VISUAL "${file}" || return 1
}

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
fuzzy_z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# binds ctrl+<space> to fzf search through cmd templates
# bookmark my own cmd with ctrl-k
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"


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




# random but will be nice to look at one day
# would be sick if I could make it show the cmd needed to invoke

# CTRL-X-1 - Invoke Readline functions by name
__fzf_readline ()
{
    builtin eval "
        builtin bind ' \
            \"\C-x3\": $(
                builtin bind -l | command fzf +s +m --toggle-sort=ctrl-r
            ) \
        '
    "
}

builtin bind -x '"\C-x2": __fzf_readline';
builtin bind '"\C-x1": "\C-x2\C-x3"'

