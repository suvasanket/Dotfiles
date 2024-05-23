#!/bin/bash

# Query the focused app name
focused_app_name=$(yabai -m query --windows | jq -r '.[0] | .app')

# Read existing app names from focusname
existing_app_names=$(cat ~/dotfiles/focusname)

# Initialize an empty array to hold app names
app_names=()

# Split existing app names into an array
IFS='|' read -ra existing_apps <<< "$existing_app_names"

# Loop through each existing app name
for app_name in "${existing_apps[@]}"; do
    # Check if the app name is the focused app
    if [[ "$app_name" != "$focused_app_name" ]]; then
        # If not, add it to the app_names array
        app_names+=("$app_name")
    fi
done

# Convert the array to a string with '|' as the separator
app_names_str=$(IFS='|'; echo "${app_names[*]}")

# Update focusname with the new list of app names
echo "$app_names_str" > ~/dotfiles/focusname

yabai --restart-service \
yabai -m window --toggle float \
yabai -m window --grid 5:5:1:1:3:3
