#!/usr/bin/bash

memory=(
	label.font="$FONT:Heavy:12"
	icon=""
	icon.font="$FONT:Bold:16.0"
	script="$PLUGIN_DIR/ram.sh"
	update_freq=4
	padding_right=5
	padding_left=0
	label.color=$APASTEL
)

sketchybar --add item memory right \
	--set memory "${memory[@]}"
