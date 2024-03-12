#!/bin/bash

# if pgrep -x "stalonetray" >/dev/null; then
# 	killall stalonetray
# else
# 	stalonetray
# fi

hidden=/tmp/syshide.lock

# if [[ $(pidof stalonetray) ]]; then
# 	if [[ ! -e $hidden ]]; then
# 		xdo hide -N stalonetray
# 		touch "$hidden"
# 	else
# 		xdo show -N stalonetray
# 		xdo raise -N stalonetray
# 		rm "$hidden"
# 	fi
# else
# 	stalonetray &
# fi
#
# exit

yoffset=0 #height of window title bar and top/bottom borders
xoffset=0 #width of left/right borders

geo=/tmp/sysgeometry.lock
wid=$(xdotool search --class "stalonetray")

if [[ $(pidof stalonetray) ]]; then
	if [[ -s $hidden ]]; then
		xdotool windowmap $(cat $hidden)
		xpos=$(($(cat $geo | awk -F',' '{print $1}') - $xoffset))
		ypos=$(($(cat $geo | awk -F',' '{print $2}') - $yoffset))
		xdotool windowmove $wid $xpos $ypos
		cat /dev/null >$hidden
	else
		echo $(xdotool getwindowgeometry $wid | grep Position | awk '{print $2}') >$geo
		xdotool windowunmap $wid
		echo $wid >$hidden
	fi
else
	rm $geo $hidden
	stalonetray &
fi
