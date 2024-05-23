#!/bin/bash

update() {
  source "$CONFIG_DIR/icons.sh"
  SSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: '  '/ SSID: / {print $2}')"
  IP="$(ipconfig getifaddr en0)"

  UPDOWN=$(ifstat -i "en0" -b 0.1 1 | tail -n1)
  DOWN=$(echo "$UPDOWN" | awk "{ print \$1 }" | cut -f1 -d ".")
  UP=$(echo "$UPDOWN" | awk "{ print \$2 }" | cut -f1 -d ".")

  DOWN_FORMAT=""
  if [ "$DOWN" -gt "999" ]; then
      DOWN_FORMAT=$(echo "$DOWN" | awk '{ printf "%03.0f Mbps", $1 / 1000}')
  else
      DOWN_FORMAT=$(echo "$DOWN" | awk '{ printf "%03.0f kbps", $1}')
  fi

  UP_FORMAT=""
  if [ "$UP" -gt "999" ]; then
      UP_FORMAT=$(echo "$UP" | awk '{ printf "%03.0f Mbps", $1 / 1000}')
  else
      UP_FORMAT=$(echo "$UP" | awk '{ printf "%03.0f kbps", $1}')
  fi



  ICON="$([ -n "$IP" ] && echo "$WIFI_CONNECTED" || echo "$WIFI_DISCONNECTED")"
  LABEL="$([ -n "$IP" ] && echo "[󰄿 $UP_FORMAT 󰄼 $DOWN_FORMAT]" || echo "Disconnected")"

  sketchybar --set $NAME icon="$ICON" label="$LABEL"
}

# click() {
#   CURRENT_WIDTH="$(sketchybar --query $NAME | jq -r .label.width)"
#
#   WIDTH=0
#   if [ "$CURRENT_WIDTH" -eq "0" ]; then
#     WIDTH=dynamic
#   fi
#
#   sketchybar --animate sin 20 --set $NAME label.width="$WIDTH"
# }
click(){
    skhd -k 'cmd - f12'
}

case "$SENDER" in
  "wifi_change") update
  ;;
  "mouse.clicked") click
  ;;
esac
