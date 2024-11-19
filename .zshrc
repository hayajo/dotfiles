#!/usr/bin/env zsh

echo "[DEBUG] eval .zshrc"

# like 'unix-filename-rubout' in bash.
autoload -U select-word-style
select-word-style bash

if type brew &>/dev/null; then
  FPATH="${HOMEBREW_PREFIX}/share/zsh-completions:$FPATH"
  autoload -Uz compinit
  compinit
fi

if [ -n "${FZF_PREFIX}" ]; then
  [[ $- == *i* ]] && source "${FZF_PREFIX}/shell/completion.zsh" 2> /dev/null
  source "${FZF_PREFIX}/shell/key-bindings.zsh"
  export FZF_DEFAULT_OPTS="--height 40% --border --color=dark"
fi

# select a git repo using fzf
# Usage: repo [QUERY]
function repo() {
  cd "$(ghq list -p | fzf --ansi --query="${1}")" || return
}
alias r='repo'

# see. zshmisc(1)
export PROMPT='%n %(4~|%-1~/.../%3~|%~) %(!.#.$) '
