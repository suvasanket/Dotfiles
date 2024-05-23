#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=$WHITE
case ${PERCENTAGE} in
   100) ICON="󰁹" 
     ;;
    9[0-9]) ICON="󰂂" 
      ;;
    8[0-9]) ICON="󰂁" 
      ;;
    7[0-9]) ICON="󰂀" 
      ;;
    6[0-9]) ICON="󰁿" 
      ;;
    5[0-9]) ICON="󰁾" 
      ;;
    4[0-9]) ICON="󰁽" 
      ;;
    3[0-9]) ICON="󰁼"; COLOR=$ORANGE
      ;;
    2[0-9]) ICON="󰁻"; COLOR=$RED
      ;;
    1[0-9]) ICON="󰁺"; COLOR=$RED
      ;;
    *) ICON="󰂎"
esac

if [[ $CHARGING != "" ]]; then
  ICON="󰂄"
  COLOR=$GREEN
  # DRAWING=off
fi

sketchybar --set $NAME drawing=$DRAWING icon="$ICON" icon.color=$COLOR
