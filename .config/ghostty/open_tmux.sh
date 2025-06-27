#!/bin/sh

TMUX=/opt/homebrew/bin/tmux

if $TMUX has-session 2>/dev/null; then
    $TMUX attach
else
    $TMUX new -s 'Home'
fi
