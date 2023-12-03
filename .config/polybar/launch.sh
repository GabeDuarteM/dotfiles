#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

MAIN_MONITOR=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)

# Launch bar1 and bar2
for m in $(polybar --list-monitors | cut -d":" -f1); do
	echo "---" | tee -a /tmp/polybar-$m.log
	BAR=secondary
	if [[ $m == $MAIN_MONITOR ]]; then
		BAR=main
	fi
	MONITOR=$m polybar --reload $BAR 2>&1 | tee -a /tmp/polybar-$BAR-$m.log &
	disown
done

echo "Bars launched..."
