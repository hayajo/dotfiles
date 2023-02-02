#!/usr/bin/env bash
# shellcheck disable=SC1090

# macOS の警告文を表示しない
export BASH_SILENCE_DEPRECATION_WARNING=1

shopt -s cmdhist

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000

PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:$PATH"

. /usr/local/opt/asdf/libexec/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

export PATH=${HOME}/bin:${PATH}

export PATH=$(go env GOPATH)/bin:${PATH}
export PATH="${HOME}/.krew/bin:${PATH}"

cmd_exists() {
  local cmd="${1:?"${FUNCNAME[0]}: cmd not specified"}"
  command -v "${cmd}" >/dev/null 2>&1
}

cmd_exists ssh-agent && [ -z "${SSH_AUTH_SOCK}" ] && eval "$(ssh-agent)"

cmd_exists brew && BREW_PREFIX="$(brew --prefix)" && export BREW_PREFIX
FZF_PREFIX="$(brew --prefix fzf)" && export FZF_PREFIX

export JAVA_HOME=`/usr/libexec/java_home -v 11`

[ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"
[ -f "${HOME}/.bashrc.local" ] && source "${HOME}/.bashrc.local"
