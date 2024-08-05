#!/bin/bash

# Brave
hyprctl dispatch workspace 2
hyprctl dispatch exec -- "/usr/bin/brave '--profile-directory=Profile 1'"
# the workspace 2 directive doesn't work as brave probably forks their PID,
# so we just go to ws 2 and wait until it can launch
sleep 0.2

# Slack
/usr/bin/slack &

# MS Teams
# function is_msteams_running() {
#   hyprctl clients -j | jq ".[] | select(.initialTitle | contains(\"Microsoft Teams\"))"
# }
# if [[ ! is_msteams_running ]]; then
# echo "MS Teams not running, launching"
/usr/bin/brave "--profile-directory=Profile 1" --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo &

# Terminal
/usr/bin/foot --title "foot: Code" -e /usr/bin/tmux new-session -A -D -s code -c /home/gabe/work/urbyo/platform &
