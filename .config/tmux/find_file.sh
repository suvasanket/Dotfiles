#!/bin/bash

fd \
    --type f \
    --hidden \
    --exclude .git \
| \
fzf-tmux \
    -m\
    -p\
    --layout=reverse \
    --scheme=history \
    --delimiter / --with-nth -1 \
    --preview='bat --theme="TwoDark" --style=numbers --color=always --line-range :500 {}' \
    --no-separator \
    -d 65% \
    --prompt='  ' \
    --tiebreak=index \
    --bind 'ctrl-d:reload(fd --search-path $HOME --type d --hidden)+change-preview(tree {})' \
    | \
xargs nvim
