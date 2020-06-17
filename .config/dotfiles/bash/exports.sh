#!/usr/bin/env bash
# export EDITOR=nvim

if cat /proc/version | grep Microsoft >/dev/null 2>&1; then
# windows environment variables

    export submit="/mnt/c/Users/Brendon*/Documents/b-submissions/"
    export doc="/mnt/c/Users/Brendon*/Documents/"
    export dow="/mnt/c/Users/Brendon*/Downloads/"
    export song="/mnt/c/Users/Brendon*/Documents/Documents/07*/music*/"
    export _Z_DATA="$HOME/FromInternet/z/.z"

    export VISUAL="nvim"
    # using this and XCsrv1.20.1.4
    #export DISPLAY=localhost:0.0
    export RIPGREP_CONFIG_PATH="$HOME/FromInternet/.ripgreprc"

elif [ "$HOME" = "/home/brendon" ]; then
# my linux env var's.
    export dow="$HOME/Downloads/"
    export submit="$HOME/Documents/Mcgill/submissions/"
    export sem="$HOME/Documents/Mcgill/5th-year/Winter/"
    export mors="$HOME/dev/dev/langs/PyStuff/morsels"
    export ZIP="$HOME/Downloads/Random/Zips/"

    export _Z_DATA="$HOME/.config/.z_data_file"
    export RIPGREP_CONFIG_PATH=$HOME/.config/.ripgreprc
    #export PYTHONSTARTUP="$HOME/PyStuff/set_ptREPL.py"
    export XDG_CONFIG_HOME="$HOME/.config"
    export PYTHONSTARTUP="$XDG_CONFIG_HOME/ptpython/config.py"

    export MANPAGER='nvim +Man!'
    export PATH="/home/$USER/bin:$PATH"

    # note that below did NOT work for changing jdk
    # export JAVA_HOME="/opt/java/jdk-11.0.6"
    # export PATH=$PATH:"/opt/java/jdk-11.0.6/bin"

    # this works maybe should add to .bash_profile tho
    export JAVA_HOME=/opt/java/jdk-11.0.6
    export PATH=$JAVA_HOME/bin:$PATH
    export GOLITEGROUP11='/home/brendon/Documents/Mcgill/5th-year/Winter/Compilers/goLite/2020_group11'

    # if we call vim __.x within nvim, use nvr and don't nest vim in terminal.
    if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
        export VISUAL="nvr"
    else
        export VISUAL="nvim"
    fi

else
    export VISUAL="vim"
fi

export EDITOR=$VISUAL


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


export HISTFILESIZE=20000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)


export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="history*:exit:ls*:cd*:clear:vim:fzf:pwd:mount*:umount*:ping*"
shopt -s histappend
# store multiline commands as one history entry
shopt -s cmdhist
function historymerge {
    history -n; history -w; history -c; history -r;
}
trap historymerge EXIT
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history/18443#18443
# so for some reason its actually a pain to get bash history working WELL
# this solution works bad but not awfully, from above link
# could check reddit and man pages myself if care to fix one day
# PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

#export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
