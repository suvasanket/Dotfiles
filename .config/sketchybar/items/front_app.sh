#!/bin/bash

front_app=(
  label.font="$FONT:Black:13.0"
  icon.background.drawing=on
  icon.background.image.scale=0.55
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
  y_offset=0
  padding_right=15
)

sketchybar --add item front_app centre         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
