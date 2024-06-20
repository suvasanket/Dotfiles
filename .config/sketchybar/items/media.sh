media=(
  script="$PLUGIN_DIR/media.sh"
  label.max_chars=50
  label.font="Menlo:Bold:10.0"
  icon.font="FiraCode Nerd Font Mono:Bold:22.0"
  icon.padding_left=15
  icon.padding_right=5
  label.padding_right=15
  # icon.color=$GREEN
  label.color=$APASTEL
  scroll_texts=off
  updates=on
  update_freq=1
  background.color=$BACKGROUND_1
  # background.border_color=$BACKGROUND_2
  background.height=30
  click_script="nowplaying-cli togglePlayPause"
  icon.y_offset=0.5
)

sketchybar  \
--add item media left \
           --set media "${media[@]}" \
           --subscribe media media_change \

#
# sketchybar --add item music center \
#            --set music label.max_chars=30 \
#                        background.drawing=off \
#                        update_freq=1                       \
#                        script="$PLUGIN_DIR/music.sh" \
#            --subscribe music media_change
