#!/bin/bash
source "$CONFIG_DIR/colors.sh"

SWAP_USED=$(sysctl vm.swapusage | awk -F'used = ' '{print $2}' | awk '{print $1}')

# Hide if swap usage is 0
if [ $(echo "$SWAP_USED == 0.00M" | bc) -eq 1 ]; then
    sketchybar --set $NAME drawing=off
    exit 0
fi

# Show in a distinct color (using Yellow as the base distinct color)
COLOR=$YELLOW
if [ $(echo "$SWAP_USED > 1024" | bc) -eq 1 ]; then
    COLOR=$RED
fi

sketchybar --set $NAME drawing=on label="${SWAP_USED}" label.color=$COLOR icon.color=$COLOR
