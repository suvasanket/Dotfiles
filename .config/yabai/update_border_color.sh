#!/usr/bin/env bash

n=$(yabai -m query --spaces --space | jq '.windows | length')
if [ $n = 1 ]; then
    borders active_color=0xffa5a5a5
else
    borders active_color=0xffe7e6e6
fi
