#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
    num_mon=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload myBar &
  done
else
  polybar --reload example &
fi

# polybar -r myBar &
# polybar -r myBar &

ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-bottom

echo message >/tmp/ipc-bottom


