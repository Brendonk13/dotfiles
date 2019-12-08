#!/usr/bin/env bash

#if pgrep -x spotify_on > /dev/null 2>&1; then
#pgrep -x spotify_on | pkill -9 > /dev/null 2>&1

if cat /home/brendonk/.config/polybar/showSongInfo.txt | rg haveClicked >/dev/null 2>&1; then
    echo "" > /home/brendonk/.config/polybar/showSongInfo.txt
else
    echo "haveClicked" > /home/brendonk/.config/polybar/showSongInfo.txt
fi
