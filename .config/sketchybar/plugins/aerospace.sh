#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # sketchybar --animate sin 10 --set $NAME icon.color=0xffabd290
    sketchybar --set $NAME icon.color=$PASTEL
else
    sketchybar --set $NAME icon.color=$APASTEL
fi
