############ HomeBrew ##############
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Shell integrations
source <(fzf --zsh)
# source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# tab complete
autoload -Uz compinit
compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive completion

# Keybindings
bindkey -e

# History
HISTSIZE=2000
HISTFILE=~/.dev/zsh/zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
if [[ $TMUX ]]; then
    alias clear='clear && tmux clear-history'
fi
alias :q="exit"
alias ta="tmux a || tmux new -s 'some'"
alias vl='nvim -c "normal \`0"'
alias vi='nvim'
alias ll="ls -laG"

alias brewbak='brew bundle dump --force --file="~/dotfiles/Brewfile"'
alias ha="/Users/suvasanketrout/codes/projects/habit_tracker/habit"

cdl() { cd "$@" && ls; }
fre_chpwd() {
    fre --add "$(pwd)"
}
typeset -gaU chpwd_functions
chpwd_functions+=fre_chpwd
