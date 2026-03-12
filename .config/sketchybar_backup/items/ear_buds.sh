#!/bin/bash

source "$CONFIG_DIR/icons.sh"
ear_bud=(
  # padding_right=-10
  icon.font="CaskaydiaCove Nerd Font:SemiBold:17.0"
  script="$PLUGIN_DIR/ear_bud.sh"
  update_freq=200
  icon="$TWS"
  icon.color=$APASTEL
  y_offset=1
  click_script="blueutil --connect \"suva's earbud\""
)

sketchybar --add item ear_bud right \
           --set ear_bud "${ear_bud[@]}" \
           --add event bluetooth_change "com.apple.bluetooth.status" \
           --subscribe ear_bud bluetooth_change
