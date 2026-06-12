#!/bin/bash
source "$CONFIG_DIR/colors.sh"

PRESSURE=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print $NF}' | sed 's/%//')
PRESSURE=$((100 - PRESSURE))

sketchybar --set $NAME label="${PRESSURE}%" label.color=$GREY icon.color=$GREY
