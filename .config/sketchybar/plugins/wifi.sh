#!/usr/bin/env sh

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="" icon=  \
    click_script="networksetup -setairportpower en0 on"
else
  sketchybar --set $NAME icon=󱄙  label="$SSID" \
  click_script="networksetup -setairportpower en0 off"
fi
