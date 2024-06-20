#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=10
    label.padding_right=10
    icon.highlight_color=$RED
    # label.color=$GREY
    # label.highlight_color=$WHITE
    label.font="sketchybar-app-font:Regular:16.0"
    label.y_offset=-1
    label.background.color=$BACKGROUND_1
    label.background.height=25
    label.background.corner_radius=9
    background.color=$BG1
    update_freq=1
    script="$PLUGIN_DIR/space.sh"
    y_offset=0
    background.height=25
    background.border_width=0
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done
spaces=(
  background.height=30
  background.color=$BACKGROUND_1
  # background.border_color=$BACKGROUND_2
  # background.border_width=0
  background.drawing=on
  y_offset=0
)
space_creator=(
  icon=+
  # icon.font="$FONT:Heavy:11.0"
  icon.font="CaskaydiaCove Nerd Font:Bold:20.0"
  padding_left=7
  padding_right=3
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  click_script="osascript /Users/suvasanketrout/.config/sketchybar/scripts/create_space.scpt"
  icon.color=$WHITE
  y_offset=0
)

# sketchybar --add item space_creator left               \
#            --set space_creator "${space_creator[@]}"   \
#            --subscribe space_creator space_windows_change
sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
                                              \
           --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_windows_change
