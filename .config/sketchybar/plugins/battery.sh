#!/bin/bash
source "$CONFIG_DIR/colors.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

COLOR=$GREY
if [ $PERCENTAGE -lt 20 ]; then
  COLOR=$RED
elif [ $PERCENTAGE -lt 50 ]; then
  COLOR=$YELLOW
fi

if [ "$CHARGING" != "" ]; then
  # If charging, show Green as "good"
  sketchybar --set $NAME label="${PERCENTAGE}% [AC]" label.color=$GREEN icon.color=$GREEN
else
  sketchybar --set $NAME label="${PERCENTAGE}%" label.color=$COLOR icon.color=$COLOR
fi
