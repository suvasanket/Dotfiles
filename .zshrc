############ HomeBrew ##############
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

# prompt
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git
setopt PROMPT_SUBST
PROMPT='%B%F{cyan}%~%f%F{243}${vcs_info_msg_0_}%f %(?.%B%F{green}>%f.%B%F{red}*%f)%b '

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
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt ignoreeof

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
# alias ha="/Users/suvasanketrout/codes/projects/habit_tracker/habit"

cdl() { cd "$@" && ls; }

# Added by Antigravity
export PATH="/Users/suvasanketrout/.antigravity/antigravity/bin:$PATH"

# Nerw CLI
export PATH="$HOME/.nerw/bin:$PATH"
