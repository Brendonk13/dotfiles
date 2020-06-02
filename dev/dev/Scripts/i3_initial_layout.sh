#!/usr/bin/env bash

declare -a workspace_names
workspace_names=(": Swift" ": Work" ": Network buys" ": NetSec" ": Git" ": Media")
# workspace_names=(": Compilers" ": Unity")
# workspace_names=(": Compilers")
open_a_terminal="exec kitty"

if type "xrandr"; then
    sleep 2
    mons -e right
    sleep 5
    num=1
    num_mon=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
    for name in "${workspace_names[@]}"; do
        # each monitor gets a workspace named:  "num: full_name"
        for i in $(seq 1 $num_mon); do

            wspace_name="$( printf '%d' $num )$name"
            w_num="$( printf '%d' $num )"

            output_monitor=""
            if [ $i -gt 1 ]; then
                output_monitor="HDMI-0"
            else
                output_monitor="DP-2"
            fi

            general_cmd="workspace $wspace_name; $open_a_terminal; workspace number $w_num; move workspace to output"
            full_cmd="$general_cmd $output_monitor"

            i3-msg "$full_cmd"

            # necessary to avoid strange undeterministic i3 behaviour
            sleep 1.2
            num=$((num + 1))
        done
    done
fi
