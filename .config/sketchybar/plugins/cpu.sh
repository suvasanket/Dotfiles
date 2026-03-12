#!/bin/bash
source "$CONFIG_DIR/colors.sh"

CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')

COLOR=$GREY
if [ $(echo "$CPU > 70" | bc) -eq 1 ]; then
  COLOR=$RED
elif [ $(echo "$CPU > 40" | bc) -eq 1 ]; then
  COLOR=$YELLOW
fi

sketchybar --set $NAME label="${CPU}%" label.color=$COLOR icon.color=$COLOR
