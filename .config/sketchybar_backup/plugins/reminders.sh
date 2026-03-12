#!/bin/bash

# --- CONFIGURATION ---
LIST_NAME="Tasks"
# ---------------------

APPLE_SCRIPT="$HOME/.config/sketchybar/scripts/get_reminder.applescript"

TASK=$(osascript "$APPLE_SCRIPT" "$LIST_NAME")

# Update SketchyBar based on the result
if [ "$TASK" = "" ]; then
    sketchybar --set $NAME drawing=off
else
    sketchybar --set $NAME drawing=on icon="󱨇 $TASK"
fi
