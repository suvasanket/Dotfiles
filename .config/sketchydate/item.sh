#!/bin/zsh

# font size of the date
DATE_FONT_SIZE=30

# font size of the time
TIME_FONT_SIZE=120

# color of the text
COLOR=0xb0ffffff

# width of each item
WIDTH=400

# y offset from the top of the screen
Y_OFFSET=100

# update frequency
UPDATE_FREQ=20

# vertical padding between the date and the time
VERT_PADDING=50

###############################################################################

# the placeholder item where popups will be drawn from
sketchydate --add item placeholder center \
    --set placeholder \
    script="./script.sh" \
    update_freq=$UPDATE_FREQ \
    popup.drawing=on \
    popup.topmost=off \
    popup.y_offset=$Y_OFFSET \
    popup.align=center \
    popup.height=$VERT_PADDING

# defaults shared between the date and time properties
sketchydate --default \
    label.color=$COLOR \
    width=$WIDTH \
    align=center

# date item
sketchydate \
    --add item date popup.placeholder \
    --set date \
    label.font="SF Pro:Bold:$DATE_FONT_SIZE"

# time item
sketchydate \
    --add item time popup.placeholder \
    --set time \
    label.font="SF Pro:Bold:$TIME_FONT_SIZE"
