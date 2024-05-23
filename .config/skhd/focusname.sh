#!/bin/bash

# Query all windows and extract the focused app name
focused_app_name=$(yabai -m query --windows | jq -r '.[0] | .app')

# Read existing app names from focusname
existing_app_names=$(cat ~/dotfiles/focusname)

# Initialize an empty array to hold unique app names
unique_app_names=()

# Split existing app names into an array
IFS='|' read -ra existing_apps <<< "$existing_app_names"

# Check if the focused app name already exists in the existing app names
if [[ ! " ${existing_apps[@]} " =~ " ${focused_app_name} " ]]; then
    # If not, add it to the unique_app_names array
    unique_app_names+=("$focused_app_name")
fi

# Append existing app names with the focused one
app_names_str=$(IFS='|'; echo "${existing_apps[*]}|${unique_app_names[*]}")

# Update focusname with the new list of app names
echo "$app_names_str" > ~/dotfiles/focusname

skhd -k 'alt - 0x32'
yabai --restart-service
