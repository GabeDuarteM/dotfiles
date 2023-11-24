#!/bin/bash

# Docker desktop
/opt/docker-desktop/bin/docker-desktop &

# Slack
/usr/bin/slack &

# Brave
/usr/bin/brave '--profile-directory=Profile 1' &

# MS Teams
/usr/bin/teams &
/usr/bin/brave "--profile-directory=Profile 1" --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo &

# Alacritty
/usr/bin/alacritty -e /usr/bin/tmux new-session -A -D -s code -c /home/gabe/work/urbyo/platform &
