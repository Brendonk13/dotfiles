#!/usr/bin/env bash

if $(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l) > 1

