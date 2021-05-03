#!/usr/bin/env bash

declare -A __COLORs

#this is sourced at the beginning of dotfiles, __cleanup_env_of_COLORs of colors meant to be called at the very end

__cleanup_env_of_COLORs() {
    unset __COLORs
}


__setup_COLORs() {
    __COLORs['NOCOL']='\033[0m'
    __COLORs['DEFAULT']='\033[0;39m'
    # __COLOs_['DEFAULT_B']='\033[1;39m'
    __COLORs['RED']='\033[0;31m'
    __COLORs['RED_B']='\033[1;31m'
    __COLORs['GREEN']='\033[0;32m'
    __COLORs['GREEN_B']='\033[1;32m'
    __COLORs['YELLOW']='\033[0;33m'
    __COLORs['YELLOW_B']='\033[1;33m'
    __COLORs['BLUE']='\033[0;34m'
    __COLORs['BLUE_B']='\033[1;34m'
    __COLORs['MAGENTA']='\033[0;35m'
    __COLORs['MAGENTA_B']='\033[1;35m'
    __COLORs['CYAN']='\033[0;36m'
    __COLORs['CYAN_B']='\033[1;36m'
    __COLORs['WHITE']='\033[0;97m'
    __COLORs['WHITE_B']='\033[1;97m'
    export __COLORs
    # echo "exported __COLORs_ = ${__COLORs_[*]}"
}


with_color() {
    no_col='\033[0m'
    # echo "$1"
    local msg="${2}${no_col}"
    case "$1" in
    # __COLOs_['DEFAULT_B']='\033[1;39m'
        nocol|NoCol|NOCOL|None|NONE)
            echo -e "${__COLORs[NOCOL]}${msg}"
            ;;
        default)
            echo -e "${__COLORs[DEFAULT]}${msg}"
            ;;
        RED|red)
            # echo 'red case'
            echo -e "${__COLORs[RED]}${msg}"
            ;;
        RED_B|red_b)
            echo -e "${__COLORs[RED_B]}${msg}"
            ;;
        GREEN|green)
            echo -e "${__COLORs[GREEN]}${msg}"
            ;;
        GREEN_B|green_b)
            echo -e "${__COLORs[GREEN_B]}${msg}"
            ;;
        YELLOW|yellow)
            echo -e "${__COLORs[YELLOW]}${msg}"
            ;;
        YELLOW_B|yellow_b)
            echo -e "${__COLORs[YELLOW_B]}${msg}"
            ;;
        BLUE|blue)
            echo -e "${__COLORs[BLUE]}${msg}"
            ;;
        BLUE_B|blue_b)
            echo -e "${__COLORs[BLUE_B]}${msg}"
            ;;
        MAGENTA|magenta)
            echo -e "${__COLORs[MAGENTA]}${msg}"
            ;;
        MAGENTA_B|magenta_b)
            echo -e "${__COLORs[MAGENTA_B]}${msg}"
            ;;
        CYAN|cyan)
            echo -e "${__COLORs[CYAN]}${msg}"
            ;;
        CYAN_B|cyan_b)
            echo -e "${__COLORs[CYAN_B]}${msg}"
            ;;
        WHITE|white)
            echo -e "${__COLORs[WHITE]}${msg}"
            ;;
        WHITE_B|white_b)
            echo -e "${__COLORs[WHITE_B]}${msg}"
            ;;

            *)
              echo 'Unknown color'
              return
            ;;
    esac
    # export __COLORs_
    # echo "exported __COLORs_ = ${__COLORs_[*]}"
}


t(){
    # echo 'in t'
    __setup_COLORs
    # echo -e "$(with_color 'RED' 'yo dudes')"
    # echo -e "$(with_color 'green' 'yo dudes')"
}
t
