#!/bin/bash

# $1 is the workspace ID (passed from items/aerospace.sh)
source "$CONFIG_DIR/colors.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Check if workspace has windows
WINDOW_COUNT=$(aerospace list-windows --workspace "$1" --count)

# Base styling: Bold
STYLE="Bold"
COLOR=$GREY

# If workspace has windows, make it Green
if [ "$WINDOW_COUNT" -gt 0 ]; then
    COLOR=$WHITE
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME \
               label="$1" \
               label.color=$BLACK \
               label.font="JetBrainsMono Nerd Font:$STYLE:12.0" \
               label.y_offset=-1 \
               background.drawing=on \
               background.color=$GREY \
               background.height=14 \
               background.y_offset=-3
else
    sketchybar --set $NAME \
               label="$1" \
               label.color=$COLOR \
               label.font="JetBrainsMono Nerd Font:$STYLE:12.0" \
               label.y_offset=-1 \
               background.drawing=off
fi
