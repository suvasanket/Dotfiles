#!/bin/bash

ear_bud=(
  # padding_right=-10
  icon.font="CaskaydiaCove Nerd Font:SemiBold:15.0"
  script="$PLUGIN_DIR/ear_bud.sh"
  update_freq=200
  # y_offset=-6
  icon="󱡏"
  icon.color=$APASTEL
  click_script="blueutil --connect \"suva's earbud\""
)

sketchybar --add item ear_bud right \
           --set ear_bud "${ear_bud[@]}" \
           --add event bluetooth_change "com.apple.bluetooth.status" \
           --subscribe ear_bud bluetooth_change
