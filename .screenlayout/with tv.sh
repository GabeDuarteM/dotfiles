#!/bin/sh
xrandr \
	--output HDMI-0 --mode 3840x2160 --rate 120 --pos 1180x0 --rotate normal \
	--output DP-0 --mode 1920x1080 --rate 144 --pos 0x2160 --rotate normal \
	--output DP-2 --mode 2560x1440 --primary --rate 144 --pos 1920x2160 --rotate normal \
	--output DP-1 --off \
	--output DP-3 --off \
	--output DP-4 --off \
	--output DP-5 --off
