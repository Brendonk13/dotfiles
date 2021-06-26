#!/usr/bin/env bash

inp="$1"
# echo "$inp"

DIR="$(dirname "$inp")"

FILE="$DIR/main.vim"
mv "$inp" "$FILE"

echo "old: $inp === new: $FILE"
