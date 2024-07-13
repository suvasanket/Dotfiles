#!/bin/bash

# Get the list of running applications, one per line
APP_LIST=$(osascript -e 'tell application "System Events" to get name of (processes where background only is false)' | tr ',' '\n' | sort -u)

# Count the number of apps
APP_COUNT=$(echo "$APP_LIST" | wc -l | sed 's/ //g')
APP_COUNT=$((APP_COUNT - 1))

# Subtract 1 from the count, but only if it's greater than 1
if [ "$APP_COUNT" -gt 1 ]; then
  APPS=$((APP_COUNT - 1))
else
  APPS=""
fi

if [ "$SENDER" = "front_app_switched" ]; then
  # If APPS is not empty, append it to INFO in square brackets
  if [ -n "$APPS" ]; then
    DISPLAY_INFO="$INFO [ +$APPS ]"
  else
    DISPLAY_INFO="$INFO"
  fi

  sketchybar --set $NAME label="$DISPLAY_INFO" icon.background.image="app.$INFO"
fi
