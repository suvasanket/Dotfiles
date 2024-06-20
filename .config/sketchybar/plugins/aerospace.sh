#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME icon.color=0xffabd290
    /Users/suvasanketrout/.local/scripts/auto.sh FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE
else
    sketchybar --set $NAME icon.color=0x9e7f7f7f
fi
