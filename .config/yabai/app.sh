#!/bin/bash

# Read app names from the file
app_names=$(cat ~/dotfiles/focusname)

# Construct the yabai rule command
rule_command="yabai -m rule --add app!=\"^($(echo $app_names | tr '|' '|' | sed 's/^/^/;s/$/$/'))$\" manage=off"

# Execute the yabai rule command
eval $rule_command
