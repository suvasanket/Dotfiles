export XDG_CONFIG_HOME="$HOME/.config"

# maven
export M2_HOME=$HOME/.dev/apache-maven-3.9.4
export PATH=$M2_HOME/bin:${PATH}

# java
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.0.2.jdk/Contents/Home"
PATH="${JAVA_HOME}/bin:${PATH}"
export PATH

# eza
export EZA_CONFIG_DIR=$HOME/.config/eza

# gum
export MANPAGER="gum pager --border none --show-line-numbers=false"

# fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--style=minimal
--color=fg:#939393,fg+:#d0d0d0,bg:#101010,bg+:#101010
--color=hl:#60c7bb,hl+:#5effec,info:#8a8a8a,marker:#ffffff
--color=prompt:#d7005f,spinner:#c392f4,pointer:#af5fff,header:#525252
--color=gutter:#101010,border:#343333,separator:#565656,scrollbar:#191919
--color=label:#aeaeae,query:#d9d9d9
--border="bold" --border-label="" --preview-window="border-bold" --prompt=" "
--marker="+" --pointer=" " --separator="" --scrollbar=""
--layout="reverse" --info="right"
'

# ruby
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
    export PATH=/opt/homebrew/opt/ruby/bin:$PATH
    export PATH=`gem environment gemdir`/bin:$PATH
fi
export PATH=$PATH:~/.gem/ruby/3.3.0/bin

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# nvm
NVM_BIN_PATH="$HOME/dotfiles/.config/nvm/versions/node/v22.2.0/bin"
export PATH="$NVM_BIN_PATH:$PATH"

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
