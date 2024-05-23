#!/usr/bin/env sh

STATE="$(blueutil --is-connected 6c-0d-e1-3b-c4-bf)"
  
if [ "$STATE" == 1 ]; then
  sketchybar --set $NAME icon="i"
else
  sketchybar --set $NAME drawing=off
fi
