sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid center \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        icon="$sid" \
        icon.padding_left=7 \
        icon.padding_right=7 \
        icon.color=$APASTEL \
        icon.font="JetBrainsMono Nerd Font:Bold:15.5" \
        label.drawing=false \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
