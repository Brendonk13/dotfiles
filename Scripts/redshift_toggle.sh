#!/usr/bin/env bash

if [[ -z `ps -A | rg redshift` ]]; then
    dunstify --icon=$HOME/Pictures/sleep.jpg "  Redshifted "
    # the -P flag resets redshift before applying changes
    redshift -P -l 45.513860:-73.570660
else
    pkill redshift
fi
