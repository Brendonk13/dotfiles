#!/usr/bin/env bash

#if pgrep -x spotify_on > /dev/null 2>&1; then
#pgrep -x spotify_on | pkill -9 > /dev/null 2>&1

if cat /home/brendon/.config/polybar/showSongInfo.txt | rg haveClicked >/dev/null 2>&1; then
    echo "" > /home/brendon/.config/polybar/showSongInfo.txt
else
    echo "haveClicked" > /home/brendon/.config/polybar/showSongInfo.txt
fi
