#!/usr/bin/env bash

n=$(yabai -m query --spaces --space | jq '.windows | length')

if [ $n = 1 ]; then
    padding=20
else
    padding=2
fi

yabai -m config --space mouse top_padding $padding
yabai -m config --space mouse bottom_padding $padding
yabai -m config --space mouse left_padding $padding
yabai -m config --space mouse right_padding $padding
