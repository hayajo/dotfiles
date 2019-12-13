#!/usr/bin/env bash
# shellcheck source=/dev/null

# User specific aliases and functions

source "${HOME}/.git-prompt.sh"
source "${HOME}/.git-completion.bash"

[ -f /etc/bashrc ] && source /etc/bashrc
[ -f "${HOME}/.fzf.bash" ] && source "${HOME}/.fzf.bash"
[ -f "${HOME}/.bashrc.local" ] && . "${HOME}/.bashrc.local"

stty werase undef
bind '"\C-w": unix-filename-rubout'

shopt -u histappend

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=1
export GIT_PS1_SHOWUNTRACKEDFILES=
export GIT_PS1_SHOWSTASHSTATE=1

export PROMPT_COMMAND="share_history; ${PROMPT_COMMAND}"

export FZF_DEFAULT_OPTS="--height 40% --border --color=dark"

function share_history() {
  history -a
  tail -r "${HISTFILE}" | awk '!a[$0]++' | tail -r > "${HISTFILE}.tmp"
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
alias ls='ls -FG'

alias vi="vim -u NONE -N"
alias tmux="tmux attach -d || tmux"
alias ag="ag -S --pager='less -R'"

alias tej='trans {en=ja}'
alias tje='trans {ja=en}'

alias g='git'
alias d='docker'
alias k='kubectl'

alias mktemp='gmktemp'

export PROMPT_COMMAND="hasjobs=\$(jobs -p); ${PROMPT_COMMAND}"
export PROMPT_DIRTRIM=2
PS1='${hasjobs:+[\j] }\[\e[1;32m\]\w$(__git_ps1)\$ \[\e[m\]'

eval "$(direnv hook bash)"
