#!/usr/bin/env bash

if [[ -z `ps -A | rg redshift` ]]; then
    dunstify --icon=$HOME/Pictures/sleep.jpg "  Redshifted "
    # start gpsd wvlan and xgps

    # sudo killall gpsd
    # sudo gpsd /dev/ttyACM2 -F /var/run/gpsd.sock
    # sudo wvdial gps
    # xgps
    # gpsdata=$( gpspipe -w | grep -m 1 TPV )
    # lat=$( echo "$gpsdata"  | jsawk 'return this.lat' )
    # lon=$( echo "$gpsdata"  | jsawk 'return this.lon' )
    # # the -P flag resets redshift before applying changes
    redshift -P -l 45.513860:-73.570660
else
    pkill redshift
fi
