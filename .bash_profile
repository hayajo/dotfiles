#!/usr/bin/env bash
# shellcheck disable=SC1090

# macOS の警告文を表示しない
export BASH_SILENCE_DEPRECATION_WARNING=1

shopt -s cmdhist

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000

PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:${PATH}
export PATH=${HOME}/bin:${HOME}/go/bin:${PATH}
export PATH="${PATH}:${HOME}/.krew/bin"

cmd_exists() {
  local cmd="${1:?"${FUNCNAME[0]}: cmd not specified"}"
  command -v "${cmd}" >/dev/null 2>&1
}

cmd_exists plenv && eval "$(plenv init -)"
cmd_exists rbenv && eval "$(rbenv init -)"
cmd_exists pyenv && eval "$(pyenv init -)"
cmd_exists nodenv && eval "$(nodenv init -)"
cmd_exists direnv && eval "$(direnv hook bash)"
cmd_exists ssh-agent && [ -z "${SSH_AUTH_SOCK}" ] && eval "$(ssh-agent)"

cmd_exists brew && BREW_PREFIX="$(brew --prefix)" && export BREW_PREFIX
FZF_PREFIX="$(brew --prefix fzf)" && export FZF_PREFIX

[ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"
