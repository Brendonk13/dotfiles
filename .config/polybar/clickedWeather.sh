#!/bin/env bash

if cat /home/brendon/.config/polybar/showWeather.txt | rg haveClicked >/dev/null 2>&1; then
    echo "" > /home/brendon/.config/polybar/showWeather.txt
else
    echo "haveClicked" > /home/brendon/.config/polybar/showWeather.txt
fi
