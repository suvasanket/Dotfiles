#!/bin/bash

source "$CONFIG_DIR/icons.sh"

wifi=(
  padding_right=7
  label.width=0
  icon="$WIFI_DISCONNECTED"
  label.font="CaskaydiaCove Nerd Font:SemiBold:14.0"
  script="$PLUGIN_DIR/wifi.sh"
  update_freq=1
  y_offset=0
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change mouse.clicked
