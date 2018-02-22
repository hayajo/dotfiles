# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export HISTTIMEFORMAT='%F %T '
export HISTSIZE=10000
export HISTFILESIZE=10000

PATH=$HOME/bin:$PATH
PATH=/usr/local/share/git-core/contrib/diff-highlight:/usr/local/sbin:$PATH

_cmd_exists() {
  local cmd=${1:?"${FUNCNAME[0]}: cmd not specified"}
  which $cmd 2>&1 >/dev/null
}

_cmd_exists plenv && eval "$(plenv init -)"
_cmd_exists rbenv && eval "$(rbenv init -)"
_cmd_exists pyenv && eval "$(pyenv init -)"
_cmd_exists nodenv && eval "$(nodenv init -)"
_cmd_exists direnv && eval "$(direnv hook bash)"
_cmd_exists ssh-agent && test -z "$SSH_AUTH_SOCK" && eval "$(ssh-agent)"

export GOPATH=$HOME
PATH="$GOPATH/bin:$(brew --prefix go)/bin:$PATH"

export PATH
