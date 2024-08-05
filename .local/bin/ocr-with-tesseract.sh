#!/bin/env zsh

local imagefile="/tmp/sloppy.$RANDOM.png"
local text="/tmp/translation"

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  sleep 0.5 && grimblast --freeze save area $imagefile 
else
  flameshot gui -p "$imagefile" 2>/dev/null || exit 1
fi

tesseract $imagefile $text 2>/dev/null
cat $text".txt" | xclip -selection c
