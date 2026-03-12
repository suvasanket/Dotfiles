#!/usr/bin/bash

sketchybar --add item reminders left \
    --set reminders \
    script="$PLUGIN_DIR/reminders.sh" \
    update_freq=30 \
    icon.color=0xff9dd274 \
    icon.font="JetBrainsMono Nerd Font:ExtraBold:14.0" \
    icon.max_chars=40 \
    icon.y_offset=1 \
    --subscribe reminders system_woke
