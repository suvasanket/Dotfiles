export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export VISUAL=nvim
export EDITOR="$VISUAL"
HOMEBREW_NO_AUTO_UPDATE=1

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)


lg(){
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
        cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
        rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

plugins=(git fzf aws zsh-autosuggestions tmux node )
autoload -U compinit && compinit //override comp
source $ZSH/oh-my-zsh.sh

# setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history


bindkey '^ ' autosuggest-accept
bindkey '^E' autosuggest-clear

alias vim="nvim"
alias s="cdh && source .zshrc"
alias c="clear"
alias cc="clear && tmux clear-history"
alias ta="tmux a || tmux"
alias v='fd --type f --hidden --exclude .git | fzf-tmux --height=50% --preview="bat --style=numbers --color=always --line-range :500 {}" | xargs nvim'
alias gd="rm -rfI .git"
alias gi="git init"
alias vbc="cdh && cd .vim && rm -rf undodir && mkdir undodir && cdh"

bindkey -s "^G" "lg^M"
bindkey -s "^T" " T^M"
bindkey -s "^v" " nvim^M"
bindkey -s "^p" " lf^M c^M"
bindkey -s "^f" " cdh^M v^M c^M"
source /Users/suvasanketrout/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
