#!/bin/sh
xrandr \
	--output DP-0 --mode 1920x1080 --rate 144 --pos 0x180 --rotate normal \
	--output DP-2 --mode 2560x1440 --primary --rate 144 --pos 1920x0 --rotate normal \
	--output HDMI-0 --off \
	--output DP-1 --off \
	--output DP-3 --off \
	--output DP-4 --off \
	--output DP-5 --off

variety --next && variety --previous
