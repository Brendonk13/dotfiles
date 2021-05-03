#!/usr/bin/env bash

DIR='mv_test_dir'
mkdir $DIR
mkdir -p $DIR/newDir/subDir
touch $DIR/newDir/f1.txt
touch $DIR/newDir/f2.txt
touch $DIR/idk.py
touch $DIR/other.txt


# can't test since can't pass the -f option yet to my wrapper function
# # edge case: use wildcard but there is only 1 match
# mv "$DIR/*.py" "$DIR/newDir/subDir"
# ls "$DIR/newDir/subDir"

# mv "$DIR/other.txt" "$DIR/new_name"

# mv "$DIR/new_name.py" "$DIR/is_txt.txt"
# mv "$DIR/*.txt" "$DIR/newDir/subDir"
# tree -F --dirsfirst -C "$DIR"
# echo "mv $DIR/newDir/* $DIR"
# mv "$DIR/newDir/*" "$DIR"
# tree -F --dirsfirst -C "$DIR"
# touch "$DIR/yeet"
# # edge case: neither have a ft
# mv "$DIR/yeet" "$DIR/nope"


# rename and change dir
# also test mv "$DIR/newDir/f2.txt" "$DIR/newDir/subDir/f222.txt
