#!/bin/env bash

if cat /home/brendonk/.config/polybar/showWeather.txt | rg haveClicked >/dev/null 2>&1; then
    echo "" > /home/brendonk/.config/polybar/showWeather.txt
else
    echo "haveClicked" > /home/brendonk/.config/polybar/showWeather.txt
fi
