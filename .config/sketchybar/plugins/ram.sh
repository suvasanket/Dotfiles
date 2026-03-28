#!/bin/bash
source "$CONFIG_DIR/colors.sh"

PRESSURE=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print $NF}' | sed 's/%//')
PRESSURE=$((100 - PRESSURE))

COLOR=$GREY
if [ $PRESSURE -gt 70 ]; then
  COLOR=$RED
elif [ $PRESSURE -gt 50 ]; then
  COLOR=$YELLOW
fi

sketchybar --set $NAME label="${PRESSURE}%" label.color=$COLOR icon.color=$COLOR
