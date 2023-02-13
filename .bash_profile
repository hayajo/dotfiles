#!/usr/bin/env bash
# shellcheck disable=SC1090

# macOS の警告文を表示しない
export BASH_SILENCE_DEPRECATION_WARNING=1

shopt -s cmdhist

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000

[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent)"
eval "$(/opt/homebrew/bin/brew shellenv)"

. "$HOMEBREW_PREFIX"/opt/asdf/libexec/asdf.sh
. "$HOMEBREW_PREFIX"/opt/asdf/etc/bash_completion.d/asdf.bash

export GOPATH=$(go env GOPATH)

export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:/usr/local/sbin:${PATH}"
export PATH="${HOME}/bin:${PATH}"
export PATH="${GOPATH}/bin:${PATH}"
export PATH=""${HOME}/.krew/bin:${PATH}""

FZF_PREFIX="$(brew --prefix fzf)" && export FZF_PREFIX
# JAVA_HOME="$(/usr/libexec/java_home -v 11)" && export JAVA_HOME

[ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
[ -f "${HOME}/.bashrc.local" ] && . "${HOME}/.bashrc.local"