#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

MEM=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')

if [ "$MEM" -gt 50 ]; then
    COLOR=$YELLOW
elif [ "$MEM" -gt 75 ]; then
    COLOR=$RED
else
    COLOR=$WHITE
fi
sketchybar -m --set "$NAME" \
    label="$MEM%" \
    icon.color=$COLOR
