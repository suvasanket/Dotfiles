#!/bin/bash

update() {
  source "$CONFIG_DIR/icons.sh"
  source "$CONFIG_DIR/colors.sh"
  SSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: '  '/ SSID: / {print $2}')"
  IP="$(ipconfig getifaddr en0)"

  if [ "$IP" ]; then
    COL=$PASTEL
    ICON=$WIFI_CONNECTED
  else
    COL=$APASTEL
    ICON=$WIFI_DISCONNECTED
  fi

  # ICON="$([ -n "$IP" ] && echo "$WIFI_CONNECTED" || echo "$WIFI_DISCONNECTED")"

  sketchybar --set $NAME icon="$ICON" icon.color=$COL
}

click(){
  osascript ~/.local/scripts/wifiToggle.scpt
}

case "$SENDER" in
  "wifi_change") update
  ;;
  "mouse.clicked") click
  ;;
esac
