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
    export sem="$HOME/Documents/Mcgill/6th-year/"
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

    # classes, nice for: $ mv assignment.py $326
    # export 326="$HOME/Documents/Mcgill/6th-year/326"
    # export 321="$HOME/Documents/Mcgill/6th-year/Prog_challenges"
    # export 429="$HOME/Documents/Mcgill/6th-year/429"
    # export chem="$HOME/Documents/Mcgill/6th-year/chem"
    # export atmo="$HOME/Documents/Mcgill/6th-year/atmo"


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


export HISTFILESIZE=50000        # Max commands saved on disk
export HISTSIZE=20000            # per session history buffer size

if [ -f $dotBashDir/setup_history.sh ]; then
    source $dotBashDir/setup_history.sh
else
    echo "setup_history.sh file is not in the same dir as my bash dotfiles"
fi
