#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh
source "$CONFIG_DIR/colors.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused --format "%{workspace}")

icons=""

APPS_INFO=$(aerospace list-windows --workspace "$1" --json --format "%{monitor-appkit-nsscreen-screens-id}%{app-name}")

IFS=$'\n'
for sid in $(echo "$APPS_INFO" | jq -r "map ( .\"app-name\" ) | .[]"); do
    icons+=$("$CONFIG_DIR/plugins/icon_map.sh" "$sid")
    icons+=""
done

for monitor_id in $(echo "$APPS_INFO" | jq -r "map ( .\"monitor-appkit-nsscreen-screens-id\" ) | .[]"); do
    monitor=$monitor_id
done

if [ -z "$monitor" ]; then
    monitor="1"
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" \
        y_offset=2 y_offset=0 \
        background.drawing=on

    if [ -z "$icons" ]; then
        sketchybar --set "$NAME" \
            display="$monitor" \
            drawing=on \
            label="$icons" \
            label.color="$ACCENT_COLOR" \
            icon.color="$ACCENT_COLOR" \
            background.color="$TRANSPARENT"
    else
        sketchybar --set "$NAME" \
            display="$monitor" \
            drawing=on \
            label="$icons" \
            label.color="$ACCENT_COLOR" \
            icon.color="$ACCENT_COLOR" \
            background.color="$BACKGROUND"
    fi
else
    if [ -z "$icons" ]; then
        sketchybar --set "$NAME" \
            display="$monitor" \
            drawing=on \
            label="$icons" \
            background.drawing=off \
            icon.color="$NONE" \
            label.color="$NONE" \
            background.color="$TRANSPARENT"
    else
        sketchybar --set "$NAME" \
            display="$monitor" \
            drawing=on \
            label="$icons" \
            label.color="$NONE" \
            icon.color="$NONE" \
            background.color="$TRANSPARENT"
    fi
fi
