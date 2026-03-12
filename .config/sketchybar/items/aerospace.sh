#!/bin/bash

# Source colors
source "$CONFIG_DIR/colors.sh"

# Add the event
sketchybar --add event aerospace_focus_change

# 1. Workspace list
for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space."$sid" left \
               --subscribe space."$sid" aerospace_focus_change \
               --set space."$sid" \
                     label="$sid" \
                     script="$CONFIG_DIR/plugins/aerospace.sh $sid" \
                     click_script="aerospace workspace $sid"
done
