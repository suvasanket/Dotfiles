#!/bin/bash
sketchybar --add event aerospace_focus_change

for sid in $(aerospace list-workspaces --all); do
    monitor=$(aerospace list-windows --workspace "$sid" --format "%{monitor-appkit-nsscreen-screens-id}")

    if [ -z "$monitor" ]; then
        monitor="1"
    fi

    sketchybar --add item space."$sid" left \
        --subscribe space."$sid" aerospace_focus_change \
        --set space."$sid" \
        display="$monitor" \
        padding_right=0 \
        icon="$sid" \
        label.padding_right=7 \
        icon.padding_left=7 \
        icon.padding_right=4 \
        background.drawing=on \
        icon.font="JetBrainsMono Nerd Font:Bold:15.0" \
        label.font="sketchybar-app-font:Regular:14.0" \
        background.color="$BACKGROUND" \
        icon.color="$ACCENT_COLOR" \
        label.color="$ACCENT_COLOR" \
        background.corner_radius=10 \
        background.height=25 \
        label.drawing=on \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
