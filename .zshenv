# init
lowercase() {
  echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}
OS=`lowercase \`uname\``
case $OS in
  "windowsnt")
    OS="windows"
    ;;
  "darwin")
    OS="mac"
    PATH=
    eval `/usr/libexec/path_helper -s`
    # for Reply https://metacpan.org/release/Reply
    export PERL_RL=EditLine
    ;;
  "sunos")
    OS="solaris"
    ;;
  "linux")
    ;;
  *)
    ;;
esac

# env
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
export PATH=$HOME/local/bin:$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vi
export LANG=ja_JP.UTF-8

# hook
[[ -f "$HOME/.zsh_hook" ]] && source "$HOME/.zsh_hook"

# plenv > perlbrew
if [ -e "$HOME/.plenv" ]; then
  export PLENV_HOME="$HOME/.plenv"
  export PATH="$PLENV_HOME/bin:$PATH"
  eval "$(plenv init -)"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export RBENV_HOME="$HOME/.rbenv"
  export PATH="$RBENV_HOME/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_HOME="$HOME/.pyenv"
  export PATH="$PYENV_HOME/bin:$PATH"
  eval "$(pyenv init -)"
fi

# nodebrew
[[ -d $HOME/.nodebrew ]] && export PATH=$HOME/.nodebrew/current/bin:$PATH

# npm
if [ -e "$HOME/.npmrc" ]; then
  export PATH="$HOME/.node_modules/bin:$PATH"
fi

# dart
if [ -d "$HOME/.dart-sdk" ]; then
  export PATH="$HOME/.dart-sdk/bin:$PATH"
fi

# golang
export GOPATH=$HOME
export PATH="/usr/local/go/bin:$PATH"

# # boot2docker
# which boot2docker >/dev/null 2>&1
# if [ $? -eq 0 ]; then
  # eval $(boot2docker shellinit 2>/dev/null)
# fi

# direnv
which direnv >/dev/null 2>&1
if [ $? -eq 0 ]; then
  eval "$(direnv hook zsh)"
fi

# docker-machine
which docker-machine >/dev/null 2>&1
if [ $? -eq 0 ]; then
  (docker-machine ls -q | grep -q default) && eval "$(docker-machine env default)"
fi

