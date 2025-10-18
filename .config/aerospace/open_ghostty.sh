#!/usr/bin/env bash

APP_NAME="Ghostty"
APP_ID="com.ghostty.ghostty"

if ! aerospace list-apps | grep -q -i "$APP_NAME"; then
    open -a "$APP_NAME"
    sleep 0.2
    aerospace layout tiling
else
    open -a "$APP_NAME"
fi
