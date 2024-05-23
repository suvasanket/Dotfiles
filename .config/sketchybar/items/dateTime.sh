#!/bin/env/bash

date=(
  icon=􀀁
  icon.drawing=off
  icon.font.size=6
  icon.padding_right=1
  icon.color=$(getcolor yellow)          
  icon.y_offset=1.5
  label.font="$FONT:Semibold:8"
  label.padding_left=0
  label.padding_right=4
  y_offset=7
  width=0                            
  update_freq=60                     
  script='sketchybar --set $NAME label="$(date "+%a, %b %d")"'
  click_script="open -a Calendar.app"
)

clock=(
  "${menu_defaults[@]}"
  icon.drawing=off          
  label.font="$FONT:Black:12" 
  label.padding_right=4           
  y_offset=-3
  update_freq=10            
  popup.align=right
  script='sketchybar --set $NAME label="$(date +"%I:%M %p")"'
  click_script="sketchybar --set clock popup.drawing=toggle; open -a Calendar.app"
)

sketchybar                                      \
  --add item date right                         \
  --set date "${date[@]}"                       \
  --subscribe date system_woke                  \
                                                \
  --add item clock right                        \
  --set clock "${clock[@]}"                     \
  --subscribe clock system_woke                 \
