#!/usr/bin/env bash

/opt/homebrew/opt/sketchybar/bin/sketchybar \
    --trigger \
    aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE

# focus finder entering empty space
EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)
if echo "$EMPTY_WORKSPACE" | grep -q "^$AEROSPACE_FOCUSED_WORKSPACE$"; then
    osascript ~/.local/scripts/finderActivator.scpt
fi
