#!/bin/bash

source "$CONFIG_DIR/colors.sh"
CAFFINATE_ID=$(pmset -g assertions | grep "caffeinate" | awk '{print $2}' | cut -d '(' -f1 | head -n 1)

# It was not a button click
if [ -z "$BUTTON" ]; then
    if [ -z "$CAFFINATE_ID" ]; then
        sketchybar --set $NAME icon.color=$APASTEL
    else
        sketchybar --set $NAME icon.color=$PASTEL
    fi
    exit 0
fi

# It is a mouse click
if [ -z "$CAFFINATE_ID" ]; then
    caffeinate -id &
    sketchybar --set $NAME icon.color=$PASTEL
else
    kill -9 "$CAFFINATE_ID"
    sketchybar --set $NAME icon.color=$APASTEL
fi
