#!/usr/bin/env bash


# -------------- Git commands --------------------------------------------------
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# lots of git bindings to look at here ^
# the forgit plugin is also sick

# remember this being annoying lol but i guess im keeping it
# Create useful gitignore files
# Usage: gi [param]
# param is a comma separated list of ignore profiles.
# If param is ommited choose interactively.

# function __gi() {
#   curl -L -s https://www.gitignore.io/api/"$@"
# }

# gi() {
#     if  [ "$#" -eq 0 ]; then
#     IFS+=","
#     for item in $(__gi list); do
#         echo $item
#     done | fzf --multi --ansi | paste -s -d "," - |
#     { read result && __gi "$result"; }
#     else
#     __gi "$@"
#     fi
# }

