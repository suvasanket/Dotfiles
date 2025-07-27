#!/bin/sh

TMUX=/opt/homebrew/bin/tmux

if $TMUX has-session 2>/dev/null; then
    $TMUX attach
else
    exec /bin/zsh -l
fi
