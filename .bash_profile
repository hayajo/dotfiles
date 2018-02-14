# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export HISTTIMEFORMAT='%F %T '

PATH=$HOME/bin:$PATH
PATH=/usr/local/share/git-core/contrib/diff-highlight:/usr/local/sbin:$PATH

export GOPATH=$HOME
PATH="$GOPATH/bin:$(brew --prefix go)/bin:$PATH"

eval "$(direnv hook bash)"
eval "$(plenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(nodenv init -)"

export PATH

