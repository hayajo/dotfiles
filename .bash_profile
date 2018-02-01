# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/bin:$PATH
PATH=/usr/local/share/git-core/contrib/diff-highlight:/usr/local/sbin:$PATH

export PATH

export GOPATH=$HOME
export PATH="$(brew --prefix go):$PATH"

eval "$(direnv hook bash)"
eval "$(plenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(nodenv init -)"

export HISTTIMEFORMAT='%F %T '
