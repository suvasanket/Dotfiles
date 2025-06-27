#!/bin/sh

if aerospace fullscreen --fail-if-noop --no-outer-gaps on; then
    sketchybar --bar topmost=false
else
    if aerospace fullscreen off; then
        sketchybar --bar topmost=true
    fi
fi
