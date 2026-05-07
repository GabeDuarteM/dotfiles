#!/usr/bin/env bash
set -euo pipefail

addr=$(hyprctl activewindow -j | jq -r '.address')
[[ -z "$addr" || "$addr" == "null" ]] && exit 0

opacity=$(hyprctl getprop "address:$addr" opacity 2>/dev/null || echo 1)

if awk -v o="$opacity" 'BEGIN { exit !(o < 0.99) }'; then
    hyprctl dispatch setprop "address:$addr" opacity 1.0
    hyprctl dispatch setprop "address:$addr" no_blur 0
else
    hyprctl dispatch setprop "address:$addr" opacity 0.5
    hyprctl dispatch setprop "address:$addr" no_blur 1
fi
