#!/bin/bash

# Read the current state of Stage Manager
STATE=$(defaults read com.apple.WindowManager GloballyEnabled 2> /dev/null)

# Toggle the state
if [[ ${STATE} = 0 || -z ${STATE} ]]; then
    yabai -m space --layout stack
    defaults write com.apple.WindowManager GloballyEnabled -bool true
    # ENABLE="true"
else
    yabai -m space --layout bsp
    defaults write com.apple.WindowManager GloballyEnabled -bool false
    # ENABLE="false"
fi
