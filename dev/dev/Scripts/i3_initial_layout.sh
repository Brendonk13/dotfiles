#!/usr/bin/env bash


declare -a workspace_names
# workspace_names=(": Planning" ": Work" ": 326" ": 429" ": Comms" ": Homelab" ": Buys" ": Media" )
workspace_names=("Plans" "Work" "3 26" "4 29" "Homelab" "Buy" "Media" )
# workspace_names=("Plans" "Work" "3 26" "4 29" "Atoc" "chem" "Homelab" "Buy" "Media" )
# workspace_names=(": Planning" ": 429" ": 326" ": Py" ": Buys" ": NetSec" ": Media" ": Stuff Manager")
open_a_terminal="exec kitty"

# these start with the numbers on which I would make them workspaces anyways
no_prefix_workspaces=("3 26" "4 29")


# ----------------------- HELPER FUNCTIONS -------------------------------------
# return 0 if $1 is in the array: $2
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

make_name () {
    num="$1"
    name="$2"
    containsElement "$name" "${no_prefix_workspaces[@]}"
    if [ $? -eq 0 ]; then
        # if $name should not have a prefix, the name of the workspace is $name
        wspace_name="$name"
    else
        wspace_name="$( printf '%d' $num ): $name"
    fi
    echo "$wspace_name"
}
# ----------------------- END HELPER FUNCTIONS ---------------------------------

# not sure why I have this if statement
if type "xrandr"; then
    sleep 2
    # why is this always done? should only be done after:
        # xrandr --query | grep " connected" | cut -d" " -f1 returns something
    num_mon=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
    if [ $num_mon -gt 1 ]; then
        mons -e right
    fi
    sleep 5
    output_monitor=""
    w_num=1

    # Create/name workspaces and open terminals in them so that they persist
    for name in "${workspace_names[@]}"; do
        for monitor in $(seq 1 $num_mon); do

            # Example name:     1: Planning
            wspace_name=$(make_name "$w_num" "$name")
            # wspace_name="$( printf '%d' $num ): $name"
            # w_num="$( printf '%d' $num )"

            if [ $monitor -gt 1 ]; then
                output_monitor="HDMI-0"
            else
                output_monitor="DP-2"
            fi

            general_cmd="workspace $wspace_name; $open_a_terminal; workspace number $w_num; move workspace to output"
            full_cmd="$general_cmd $output_monitor"

            i3-msg "$full_cmd"

            # necessary to avoid strange undeterministic i3 behaviour
            sleep 1.2
            w_num=$((w_num + 1))
        done
    done
fi


