# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f ~/.config/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/LF_ICONS)" \
		&& export LF_ICONS
}

# ~/.tmux/plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
