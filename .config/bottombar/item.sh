media=(
  script="./script.sh"
  label.max_chars=50
  label.font="Futura:Medium:12.0"
  label.color=0x7affffff
  icon.color=0x7affffff
  icon.font="FiraCode Nerd Font Mono:Bold:19.0"
  icon.padding_left=15
  icon.padding_right=5
  label.padding_right=15
  scroll_texts=off
  update_freq=1
  background.height=40
  background.color=0xba252525
  background.corner_radius=10
  background.border_width=1
  background.border_color=0xff414550
  click_script="nowplaying-cli togglePlayPause"
  icon.y_offset=6
  label.y_offset=7
)

bottombar  \
--add item media right \
           --set media "${media[@]}" \
           --subscribe media media_change \
