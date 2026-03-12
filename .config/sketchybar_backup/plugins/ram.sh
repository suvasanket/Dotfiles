#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

MEM=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')

if ((MEM < 55)); then
    ICON_COLOR=$WHITE
    LABEL_COLOR=$APASTEL
elif ((MEM < 65)); then
    ICON_COLOR=$YELLOW
    LABEL_COLOR=$YELLOW
else
    ICON_COLOR=$RED
    LABEL_COLOR=$RED
fi
sketchybar -m --set "$NAME" \
    label="$MEM%" \
    icon.color=$ICON_COLOR \
    label.color=$LABEL_COLOR
