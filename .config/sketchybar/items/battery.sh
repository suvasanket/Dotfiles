#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="JetBrainsMono Nerd Font:Regular:14.0"
  label.font="JetBrainsMono Nerd Font:Bold:14.0"
  label.color=$APASTEL
  padding_right=5
  padding_left=0
  # icon.drawing=off
  update_freq=120
  updates=on
  y_offset=0
  click_script="$SCRIPTS_DIR/batfi.sh"
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
