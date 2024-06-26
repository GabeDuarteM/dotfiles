#!/bin/bash

# Slack
/usr/bin/slack &

# Brave
/usr/bin/brave '--profile-directory=Profile 1' &

# MS Teams
/usr/bin/brave "--profile-directory=Profile 1" --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo &

# Alacritty
/usr/bin/alacritty --title Code -e /usr/bin/tmux new-session -A -D -s code -c /home/gabe/work/urbyo/platform &
