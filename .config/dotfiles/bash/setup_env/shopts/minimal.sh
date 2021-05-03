#!/usr/bin/env bash

bind 'set bell-style none'

## SMARTER TAB-COMPLETION (Readline bindings) ##
#
# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# use these to move by whitespace delim words
bind '"\C-f":vi-fWord'
bind '"\C-b":vi-bWord'

# correct minor spelling mistakes
shopt -s cdspell

# only suggest directories during tab completion of cd command
complete -d cd
