#!/usr/bin/env bash

declare -a workspace_names
workspace_names=(": Compilers" ": Unity" ": Threads" ": DB")
# workspace_names=(": Compilers" ": Unity")
# workspace_names=(": Compilers")
open_a_terminal="exec kitty"

if type "xrandr"; then
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
            num=$((num + 1))

            # necessary to avoid strange undeterministic i3 behaviour
            sleep 0.9
        done
    done
fi

# so the key to getting this working is to make a terminal in all windows after naming them for persistence.
# then using "workspace NUMBER ..." to switch back to this created workspace and move it to the correct monitor

# sleep 1
# num_mon=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

# num=1
# for name in "${workspace_names[@]}"; do
#     for i in $(seq 1 $num_mon); do

#         # full_name="$( printf '%d' $num )$name"
#         half="$( printf '%d' $num )"
#         cmd=""
#         switch_wspace="$cmd_prefix number $half"
#         if [ $i -gt 1 ]; then
#             cmd="$switch_wspace; move workspace to output HDMI-0"
#         else
#             cmd="$switch_wspace; move workspace to output DP-2"
#         fi
#         echo "$cmd"
#         i3-msg "$cmd"
#         sleep 0.4
#         num=$((num + 1))
#     done
# done

