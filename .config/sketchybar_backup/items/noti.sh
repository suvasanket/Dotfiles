#!/bin/bash


# Define the generation icon item
generation_icon=(
    position=right
    label=""
    label.font="CaskaydiaCove Nerd Font:SemiBold:17.0"
    width=30                       # Fixed width for the icon
    padding_left=5
    padding_right=5
)

sketchybar --add item generation_icon right \
    --set generation_icon "${generation_icon[@]}"

# ... (Rest of your config, e.g., other items or plugins)
