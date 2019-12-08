#!/bin/bash

input=$1
buttons="  "
#echo "$buttons"
if ! pgrep -x spotify; then
    # only show icon if spotify is not running.
    echo ""
    input="nada"
fi
#!pgrep -x spotify && echo  && exit 0

if [ "$#" -lt 2 ]; then
    input="nada"
fi
if [ "$input" == "play" ]; then
    #/usr/bin/playerctl play-pause
    #/home/brendonk/Scripts/spotify-sp/fa6258f3ff7b17747ee3/sp sp-dbus PlayPause >/dev/null 2>&1
    /usr/bin/playerctl play-pause &
elif [ "$input" == "next" ]; then
    /usr/bin/playerctl next &
elif [ "$input" == "prev" ]; then
    /usr/bin/playerctl previous &
    #>/dev/null 2>&1; then
fi

if pgrep -x spotify; then
    echo "$buttons"
fi

