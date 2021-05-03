#!/usr/bin/env bash

# make this work with https://wiki.archlinux.org/index.php/backlight
# make sure to add curr user to video group !
alias bright='echo 255 | sudo tee /sys/class/backlight/amdgpu_bl0/brightness'
