#!/usr/bin/env bash

declare -a workspace_names
# workspace_names=(": Compilers" ": Unity" ": Threads" ": DB")
workspace_names=(": Compilers" ": Unity")
# workspace_names=(": Compilers")
cmd_prefix="workspace "
cmd_postfix="; exec kitty"

if type "xrandr"; then
    num=1
    num_mon=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
    for name in "${workspace_names[@]}"; do
        # echo $name
        # each monitor gets a workspace named:  "num: full_name"
        for i in $(seq 1 $num_mon); do
            full_name="$( printf '%d' $num )$name"
            cmd="$cmd_prefix$full_name$cmd_postfix"
            i3-msg $cmd
            num=$((num + 1))
        done
    done
fi

