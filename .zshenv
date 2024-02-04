#zsh
export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/dev/.oh-my-zsh"

##maven
export M2_HOME=$HOME/dev/apache-maven-3.9.4
export PATH=$M2_HOME/bin:${PATH}

#java
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.0.2.jdk/Contents/Home"
PATH="${JAVA_HOME}/bin:${PATH}"
export PATH

#emacs
export PATH="/opt/homebrew/Cellar/emacs-plus@28/28.2/bin:$PATH"
alias ec="/opt/homebrew/Cellar/emacs-plus@28/28.2/bin/emacsclient"
alias te="/opt/homebrew/Cellar/emacs-plus@28/28.2/bin/emacs -nw"

#nvim default
export VISUAL=nvim
export EDITOR="$VISUAL"

#HomeBrew
HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_AUTOREMOVE=1

# env for webapp
export MONOGO_USERNAME="hello"
export MONOGO_PASSWORD="free"
