#!/bin/bash

source ~/.zshenv

count=$(~/.config/eww/.venv/bin/python ~/.config/eww/modules/disclose/scripts/logger.py stats | jq .total)
is_dnd=$(dunstctl is-paused)

icon=""

if [ "$is_dnd" = "true" ]; then
	icon="%{F#FF0000}%{F-}"
fi

if [ "$count" -gt 0 ]; then
	echo "$icon  $count"
else
	echo "$icon "
fi
