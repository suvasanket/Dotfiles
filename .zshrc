############ HomeBrew ##############
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

############ ZINIT ##############

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

zinit ice wait lucid
zinit light olets/zsh-abbr

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Add in snippets (omz style)
zinit ice wait lucid
zinit snippet OMZP::command-not-found
# zinit snippet OMZP::sudo
# zinit snippet OMZP::git

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -v
bindkey '^l' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
if [[ $TMUX ]]; then
    alias clear='clear && tmux clear-history'
fi
alias cs=". ~/.local/scripts/cht_sh.sh"
alias ls="eza --icons --color-scale -x"
alias :q="exit"
alias ff="tmux new-window 'fd --type f --hidden |fzf|xargs nvim'"
alias f='/Users/suvasanketrout/.config/tmux/find_file.sh'
alias gd="rm -rfI .git"
alias gi="git init"
alias vuc="cd && cd .vim && rm -rf undodir && mkdir undodir && cdh"
alias "mvn create"="mvn archetype:generate"
alias ta="tmux a || tmux new -s 'Home'"
alias vl='nvim -c "normal \`0"'
cdl() { cd "$@" && ls; }
gemuninstall() { gem list --no-version | grep'$@' | xargs gem uninstall}

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
