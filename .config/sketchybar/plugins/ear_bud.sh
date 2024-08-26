#!/usr/bin/env sh

BUD_NAME="suva's earbud"
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

STATE="$(blueutil --is-connected "$BUD_NAME")"

if [ "$STATE" == 1 ]; then
  sketchybar --set $NAME icon.color=$PASTEL \
  click_script="blueutil --disconnect \"$BUD_NAME\""
else
  sketchybar --set $NAME icon.color=$APASTEL \
    click_script="blueutil --connect \"$BUD_NAME\""
fi
