#!/bin/bash

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

PATH=$HOME/bin:$PATH

stty werase undef
bind '"\C-w": unix-filename-rubout'

export LANG='ja_JP.UTF-8'

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# プロンプトが表示されるごとにコマンド履歴の追記とリロードを行う
function share_history {
    history -a # append
    history -c # clear
    history -r # reload
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=100000
export HISTTIMEFORMAT='%s '

# git-prompt
if type __git_ps1 >/dev/null 2>&1; then
  PROMPT_COMMAND="__git_ps1 '\[\e[0;36m\]\t \u \W\[\e[m\]' '\\\$ '; $PROMPT_COMMAND"
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_SHOWCOLORHINTS=true
fi

# tmux特有の設定
if [[ ! -z "$TMUX" ]]; then
  alias osascript="reattach-to-user-namespace osascript"
fi

# docker-machine
if [[ -z "$DOCKER_HOST" ]]; then
  eval "$(docker-machine env default)"
fi

# golang
if [[ -z "$GOPATH" ]]; then
  export GOPATH=$HOME
  export PATH="$(brew --prefix go):$PATH"
fi

## plenv
if [[ -z "$PLENV_HOME" ]]; then
  export PLENV_HOME="$HOME/.plenv"
  eval "$(plenv init -)"
fi

## rbenv
if [[ -z "$RBENV_HOME" ]]; then
  export RBENV_HOME="$HOME/.rbenv"
  eval "$(rbenv init -)"
fi

## pyenv
if [[ -z "$PYENV_HOME" ]]; then
  export PYENV_HOME="$HOME/.pyenv"
  eval "$(pyenv init -)"
fi

## nodenv
if [[ -z "$NODENV_HOME" ]]; then
  export NODENV_HOME="$HOME/.nodenv"
  eval "$(nodenv init -)"
fi

export PATH
