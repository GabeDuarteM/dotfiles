#!/bin/bash

# Docker desktop
/opt/docker-desktop/bin/docker-desktop &

# Slack
/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=slack --file-forwarding com.slack.Slack @@u %U @@ &

# Brave
flatpak 'run' '--command=brave' 'com.brave.Browser' '--profile-directory=Profile 1' &

# MS Teams
flatpak 'run' '--command=brave' 'com.brave.Browser' '--profile-directory=Profile 1' '--app-id=cifhbcnohmdccbgoicgdjpfamggdegmo' &

alacritty -e /usr/bin/tmux new-session -A -D -s code -c /home/gabe/work/urbyo/platform &
