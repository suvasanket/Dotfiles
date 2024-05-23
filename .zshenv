export XDG_CONFIG_HOME="$HOME/.config"

##maven
export M2_HOME=$HOME/dev/apache-maven-3.9.4
export PATH=$M2_HOME/bin:${PATH}

#java
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.0.2.jdk/Contents/Home"
PATH="${JAVA_HOME}/bin:${PATH}"
export PATH

## Python ##
export PATH="$(brew --prefix)/opt/python@3.12/libexec/bin:$PATH"

## Ruby ##
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi
export PATH=$PATH:~/.gem/ruby/3.3.0/bin
