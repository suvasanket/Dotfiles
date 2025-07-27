export XDG_CONFIG_HOME="$HOME/.config"

# java
# JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.0.2.jdk/Contents/Home"
# PATH="${JAVA_HOME}/bin:${PATH}"
# export PATH

# ruby
# if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
#     export PATH=/opt/homebrew/opt/ruby/bin:$PATH
#     export PATH=`gem environment gemdir`/bin:$PATH
# fi
# export PATH=$PATH:~/.gem/ruby/3.3.0/bin

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# python
export PATH="$(/opt/homebrew/bin/brew --prefix)/opt/python@3.13/libexec/bin:$PATH"

# nvm
NVM_BIN_PATH="$HOME/dotfiles/.config/nvm/versions/node/v22.2.0/bin"
export PATH="$NVM_BIN_PATH:$PATH"
#
# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
