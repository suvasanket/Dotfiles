#!/bin/zsh

date=$(date +'%A, %B %-d')
uppercase_date=$(echo $date | tr '[:lower:]' '[:upper:]')

sketchydate --set date label="$uppercase_date"

time=$(date +'%I:%M')

sketchydate --set time label="$time"
