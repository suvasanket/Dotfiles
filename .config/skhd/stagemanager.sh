#!/bin/bash

# Read the current state of Stage Manager
STATE=$(defaults read com.apple.WindowManager GloballyEnabled 2> /dev/null)

# Toggle the state
if [[ ${STATE} = 0 || -z ${STATE} ]]; then
    yabai -m space --layout stack
    skhd -k 'space'
    skhd -k 'cmd + shift - f3'
    # defaults write com.apple.WindowManager GloballyEnabled -bool true
else
    yabai -m space --layout bsp
    skhd -k 'space'
    skhd -k 'cmd + shift - f3'
    # defaults write com.apple.WindowManager GloballyEnabled -bool false
fi
