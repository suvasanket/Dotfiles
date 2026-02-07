#!/bin/bash

ds=/Users/suvasanketrout/Developer/dir_sync/dirsync
sbar=/opt/homebrew/opt/sketchybar/bin/sketchybar

# run sketchybar
$sbar &

# dirsync
killall dirsync
$ds -s "/Users/suvasanketrout/Documents" -d "/Volumes/SanDisk/Documents" &
