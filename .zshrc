## exports ##
export MANPAGER="gum pager"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#939393,fg+:#d0d0d0,bg:#181818,bg+:#181818
--color=hl:#60c7bb,hl+:#5effec,info:#8a8a8a,marker:#ffffff
--color=prompt:#d7005f,spinner:#c392f4,pointer:#af5fff,header:#525252
--color=gutter:#181818,border:#343333,separator:#565656,scrollbar:#191919
--color=label:#aeaeae,query:#d9d9d9
--border="bold" --border-label="" --preview-window="border-bold" --prompt=" "
--marker="+" --pointer=" " --separator="" --scrollbar=""
--layout="reverse" --info="right"'

############ HomeBrew ##############

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
## Python ##
export PATH="$(brew --prefix)/opt/python@3.12/libexec/bin:$PATH"

## Ruby ##
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

export PATH=$PATH:~/.gem/ruby/3.3.0/bin

## kitty ##
# if test -n "$KITTY_INSTALLATION_DIR"; then
#     export KITTY_SHELL_INTEGRATION="enabled"
#     autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
#     kitty-integration
#     unfunction kitty-integration
# fi

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
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets (omz style)
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^r' 'gum filter < $HISTFILE --height 20'
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
alias ls="exa --icons --color-scale -x"
alias s="exec zsh"
alias :q="exit"
alias gsed="sed"
alias ff="tmux new-window 'fd --type f --hidden |fzf|xargs nvim'"
alias f='/Users/suvasanketrout/.config/tmux/find_file.sh'
alias gd="rm -rfI .git"
alias gi="git init"
alias vuc="cd && cd .vim && rm -rf undodir && mkdir undodir && cdh"
alias "mvn create"="mvn archetype:generate"
alias ta="tmux a || tmux new -s 'Home'"
alias v="nvim"
alias vo="nvim ."
alias vf="nvim -c 'Telescope smart_open'"
alias vl="nvim -c'SessionManager load_last_session'"
cdl() { cd "$@" && ls; }
gemuninstall() { gem list --no-version | grep'$@' | xargs gem uninstall}
alias doom="~/.config/emacs/bin/doom"

# Shell integrations
FZF_CTRL_R_COMMAND= source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH=$PATH:/Users/suvasanketrout/.spicetify
