#!/bin/env zsh

local imagefile="/tmp/sloppy.$RANDOM.png"
local text="/tmp/translation"
# local slop=$(slop -f "%g") || exit 1
# maim -g "$slop" $imagefile
flameshot gui -p "$imagefile" 2>/dev/null || exit 1
tesseract $imagefile $text 2>/dev/null
cat $text".txt" | xclip -selection c
