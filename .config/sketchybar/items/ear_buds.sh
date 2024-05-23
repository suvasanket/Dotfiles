#!/bin/bash

ear_bud=(
  padding_right=7
  label.width=0
  label.font="CaskaydiaCove Nerd Font:SemiBold:14.0"
  script="$PLUGIN_DIR/ear_bud.sh"
  update_freq=1
  y_offset=-6
)

sketchybar --add item ear_bud right \
           --set ear_bud "${ear_bud[@]}" \
           --add event bluetooth_change "com.apple.bluetooth.status" \
           --subscribe ear_bud bluetooth_change
