#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

[ -f /etc/bashrc ] && source /etc/bashrc

stty werase undef
bind '"\C-w": unix-filename-rubout'

shopt -u histappend
export PROMPT_COMMAND="share_history; ${PROMPT_COMMAND}"

function share_history() {
  if which tac >/dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  history -a
  "${tac}" "${HISTFILE}" | awk '!a[$0]++' | "${tac}" > "${HISTFILE}.tmp"
  [ -f "${HISTFILE}.tmp" ] && mv "${HISTFILE}"{.tmp,} && history -c && history -r
}

# Open file or dir with Visual Studio Code
# Usage: vscode [FILE or DIR]
function vscode() {
    VSCODE_CWD="${PWD}" open -n -b "com.microsoft.VSCode" --args "$@"
}

# Select a git repo using fzf
# Usage: repo [QUERY]
function repo() {
  cd "$(ghq list -p | fzf --ansi --query="${1}")" || return
}

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -FG --color'

alias vi="vim -u NONE -N"
alias tmux="tmux attach -d || tmux"
alias ag="ag -S --pager='less -R'"

alias tej='trans {en=ja}'
alias tje='trans {ja=en}'

alias g='git'
alias d='docker'
alias k='kubectl'
alias v='view'

alias mktemp='gmktemp -p ~/tmp'

if [ -n "${BREW_PREFIX}" ] && [ -f "${BREW_PREFIX}/etc/bash_completion" ]; then
  source "${BREW_PREFIX}/etc/bash_completion"
  export PROMPT_DIRTRIM=2
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWUPSTREAM=1
  export GIT_PS1_SHOWUNTRACKEDFILES=
  export GIT_PS1_SHOWSTASHSTATE=1
  export PS1='\[\e[01;34m\]\w\[\e[00;33m\]$(__git_ps1)\[\e[01;34m\]\$ \[\e[m\]'
fi

if [ -n "${FZF_PREFIX}" ]; then
  [[ $- == *i* ]] && source "${FZF_PREFIX}/shell/completion.bash" 2> /dev/null
  source "${FZF_PREFIX}/shell/key-bindings.bash"
  export FZF_DEFAULT_OPTS="--height 40% --border --color=dark"
fi
