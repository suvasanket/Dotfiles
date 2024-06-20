#!/bin/bash

source "$CONFIG_DIR/icons.sh"

wifi=(
  padding_right=7
  icon.font="FiraCode Nerd Font:Bold:28.0"
  icon.color=$APASTEL
  label.drawing=false
  update_freq=1
  script="$PLUGIN_DIR/wifi.sh"
  y_offset=0
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change mouse.clicked
