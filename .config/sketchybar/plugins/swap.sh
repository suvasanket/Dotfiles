#!/bin/bash
source "$CONFIG_DIR/colors.sh"

SWAP_USED=$(sysctl -n vm.swapusage | awk '{print $7}' | sed 's/M//')

# Hide if 0
if [ $(echo "$SWAP_USED == 0" | bc) -eq 1 ]; then
  sketchybar --set $NAME drawing=off
  exit 0
fi

# Show in a distinct color (using Yellow as the base distinct color)
COLOR=$YELLOW
if [ $(echo "$SWAP_USED > 1024" | bc) -eq 1 ]; then
  COLOR=$RED
fi

sketchybar --set $NAME drawing=on label="${SWAP_USED}M" label.color=$COLOR icon.color=$COLOR
