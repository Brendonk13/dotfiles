#!/usr/bin/env bash

if ! hash rga > /dev/null 2>&1; then
    alias rgaf=rga_fzf
    rga_fzf() {
        local RG_PREFIX="rga --files-with-matches"
        local file
        file="$(
            FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
                fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                                --phony -q "$1" \
                                --bind "change:reload:$RG_PREFIX {q}" \
                                --preview-window="70%:wrap"
        )" &&
        echo "opening $file" &&
        setsid xdg-open "$file"
    }
else
    echo 'rga not found, rgaf alias not created'
fi
