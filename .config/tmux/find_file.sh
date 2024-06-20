#!/bin/bash

fd \
    --type f \
    --search-path $HOME \
    --hidden \
    --exclude .git \
| \
fzf-tmux \
    -p\
    --layout=reverse \
    --border=rounded \
    --scheme=history \
    --delimiter / --with-nth -1 \
    --preview='bat --theme="TwoDark" --style=numbers --color=always --line-range :500 {}' \
    --no-separator \
    -h 75% \
    -w 70% \
    --prompt='󰈞 ' \
    --pointer='' \
    --tiebreak=index \
    --bind 'ctrl-d:reload(fd --search-path $HOME --type d --hidden)+change-preview(tree {})' \
    | \
xargs nvim
