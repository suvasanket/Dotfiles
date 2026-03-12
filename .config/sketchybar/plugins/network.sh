#!/bin/bash
source "$CONFIG_DIR/colors.sh"

# Check for internet connectivity
if scutil -r 1.1.1.1 | grep -q "Reachable"; then
  sketchybar --set $NAME drawing=off
else
  # Blinking effect: toggle drawing state if already drawing
  CURRENT_DRAWING=$(sketchybar --query $NAME | jq -r ".geometry.drawing")
  if [ "$CURRENT_DRAWING" = "on" ]; then
    sketchybar --set $NAME drawing=off
  else
    sketchybar --set $NAME drawing=on icon="󰤮" icon.color=$RED
  fi
fi
