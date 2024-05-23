#zsh
export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/dev/.oh-my-zsh"

#nvim default
export VISUAL=nvim
export EDITOR="$VISUAL"

#HomeBrew
HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_AUTOREMOVE=1

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f ~/.config/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/LF_ICONS)" \
		&& export LF_ICONS
}


# fzf
export CONFIGURATION="
--search-path $HOME/dotfiles
--search-path $HOME/.local
--search-path $HOME/codes
--search-path $HOME/Documents
--search-path $HOME/Archive
"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow $CONFIGURATION . "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow $CONFIGURATION . "

#zoxide
eval "$(zoxide init zsh)"

#starship
eval "$(starship init zsh)"
