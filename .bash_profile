#!/usr/bin/env bash
# shellcheck source=/dev/null

# Get the aliases and functions

[ -f ~/.bashrc ] && source ~/.bashrc

# User specific environment and startup programs

# shellcheck source=/dev/null
[ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"

shopt -s cmdhist

export HISTFILE=~/.bash.log
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
export HISTFILESIZE=10000

export PATH=${HOME}/go/bin:/usr/local/sbin:${PATH}

cmd_exists() {
  local cmd="${1:?"${FUNCNAME[0]}: cmd not specified"}"
  command -v "${cmd}" >/dev/null 2>&1
}

cmd_exists plenv && eval "$(plenv init -)"
cmd_exists rbenv && eval "$(rbenv init -)"
cmd_exists pyenv && eval "$(pyenv init -)"
cmd_exists nodenv && eval "$(nodenv init -)"
cmd_exists ssh-agent && [ -z "${SSH_AUTH_SOCK}" ] && eval "$(ssh-agent)"