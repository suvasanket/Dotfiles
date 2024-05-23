#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  var icon_strip
  draw=on
  if [ "${apps}" != "" ]; then
    draw=on
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    draw=off
    unset icon_strip
  fi

  sketchybar --animate sin 10 --set space.$space label="$icon_strip" label.drawing=$draw
fi
