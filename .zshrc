#term color
export TERM="xterm-256color"
[[ -n $TMUX ]] && export TERM="tmux-256color"

# fzf
export CONFIGURATION="--search-path $HOME/.config
--search-path $HOME/.local
--search-path $HOME/codes
--search-path $HOME/neorg
--search-path $HOME/org
"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow $CONFIGURATION . "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow $CONFIGURATION . "
#zoxide
eval "$(zoxide init zsh)"

#starship
eval "$(starship init zsh)"

#AutoComplete
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#kitty-terminal
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-cursor"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
    # kitty +kitten icat --align left ~/dev/splash_img/pochita.png
fi
#functions

#lazygit
lg(){
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
        cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
        rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
export XDG_CONFIG_HOME="$HOME/.config"

alias za='selected_session=$(zellij ls | fzf -0 -1 --layout=reverse --height=50% --no-separator); [ -n "$selected_session" ] && zellij a "$selected_session" || (read -r "name?Enter a session name: " && zellij -s "$name")'

#OMZ
plugins=(
    git
    zsh-autosuggestions
    tmux
    macos
    thefuck
    ripgrep
    common-aliases
    fzf
    zsh-interactive-cd
)

autoload -U compinit && compinit //override comp
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST ##spedup completion by cache
source $ZSH/oh-my-zsh.sh

# setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
setopt HIST_IGNORE_SPACE

#vim
bindkey -v

functions jrun (){
    javac $1.java && java $1 && rm $1.class
}

#aliases
if [[ $TMUX ]]; then
    alias clear='clear && tmux clear-history'
fi
alias ls=exa
alias vim="nvim"
alias s="exec zsh"
alias 'cd'="z"
alias f='fd --type f --hidden | fzf --height=50% --no-separator --layout=reverse --preview="bat --style=numbers --color=always --line-range :500 {}" | xargs nvim'
alias gd="rm -rfI .git"
alias gi="git init"
alias vuc="cd && cd .vim && rm -rf undodir && mkdir undodir && cdh"
alias "mvn create"="mvn archetype:generate"
alias proj_t="touch .t && chmod +x .t && echo -e '#!/usr/bin/env bash\n nvim' > .t"
alias t="./.tmux/plugins/t-smart-tmux-session-manager/bin/t"
alias ta="tmux a || tmux"

#keys
bindkey '^I' autosuggest-accept
bindkey -s '^f' "f && clear^M"
bindkey -s '^z' "fg^M"
bindkey -s '^t' "t^M"

# kitty +kitten icat --align left ~/.dev/splash_img/pochita.png
# /Users/suvasanketrout/.iterm2/imgcat ~/.dev/splash_img/pochita.png
alias pochita="/Users/suvasanketrout/.iterm2/imgcat ~/dev/splash_img/pochita.png"

# ta || tmux
source /Users/suvasanketrout/dev/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
test -e /Users/suvasanketrout/.iterm2_shell_integration.zsh && source /Users/suvasanketrout/.iterm2_shell_integration.zsh || true
