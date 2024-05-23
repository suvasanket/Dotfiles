#!/usr/bin/env sh

NPCLI="$HOME/.local/bin/nowplaying-cli"

PLAYBACK_RATE="$($NPCLI get PlaybackRate)"
TRACK="$($NPCLI get title)"

if [ "$PLAYBACK_RATE" == "0" ]; then
    ICON=󰎍
else
    ICON=󰝚
fi
  
if [ "$PLAYBACK_RATE" != "null" ]; then
  bottombar --set $NAME icon="$ICON" label="$TRACK" drawing=on click_script="nowplaying-cli togglePlayPause"
else
  bottombar --set $NAME drawing=off
fi
