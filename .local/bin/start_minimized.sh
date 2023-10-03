#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: $0 <program_to_run> <program_name>"
	exit 1
fi

program_to_run="$1"
program_name="$2"

xdotool search --onlyvisible --sync --classname "$program_name" windowminimize &

eval "$program_to_run"
