#!/bin/bash

sketchybar --add item caffeinate right \
    --set caffeinate script="$PLUGIN_DIR/caffeinate.sh" \
    click_script="$PLUGIN_DIR/caffeinate.sh" \
    icon.font="JetBrainsMono Nerd Font:Bold:17.0" \
    padding_right=5 \
    padding_left=0 \
    y_offset=1 \
    icon= \
    icon.color=$APASTEL
