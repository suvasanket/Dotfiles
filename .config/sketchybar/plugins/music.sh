#!/usr/bin/env sh

NPCLI="$HOME/.local/bin/nowplaying-cli"

PLAYBACK_RATE="$($NPCLI get PlaybackRate)"
TRACK="$($NPCLI get title)"

if [ "$PLAYBACK_RATE" == "0" ]; then
    ICON=
else
    ICON=󰎈
fi
  
if [ "$PLAYBACK_RATE" != "null" ]; then
  sketchybar --set $NAME label="$TRACK" drawing=on icon=$ICON
else
  sketchybar --set $NAME drawing=off
fi
