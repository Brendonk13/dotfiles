#!/usr/bin/env bash

alias hdmi='xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60'

# monitors
# alias mon='mons -e right'
alias mon='mons -e left'
# ^--> my screen on left
# For multiple monitors consider changing to below, which works for 1 monitor
# xrandr --output $( xrandr | grep 'HDMI.* connected' | head -n1 | awk '{ print $1 }' ) --off
alias monoff='xrandr --output HDMI-A-0 --off'

setup_monitor() {
    if [ $# -lt 1 ]; then
        echo "USAGE: setup_monitor MONITOR_SIDE"
        return
    fi
    local MONITOR_SIDE="$1"
    echo "mons -e $MONITOR_SIDE"
    # echo "$MONITOR_SIDE"
    mons -e "$MONITOR_SIDE" && bash "$HOME/.config/polybar/launch.sh" > /dev/null 2>&1
}
alias m=setup_monitor


