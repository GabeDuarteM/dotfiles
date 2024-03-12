#!/bin/bash

source ~/.zshenv

count=$(~/.config/eww/.venv/bin/python ~/.config/eww/modules/disclose/scripts/logger.py stats | jq .total)
is_dnd=$(dunstctl is-paused)

icon="%{T2}%{T-}"

if [ "$is_dnd" = "true" ]; then
	icon="%{T2}%{F#FF0000}%{F-}%{T-}"
fi

if [ "$count" -gt 0 ]; then
	echo "$icon $count"
else
	echo "$icon"
fi
