# User specific aliases and functions

stty werase undef
bind '"\C-w": unix-filename-rubout'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -FG'

alias vi="vim -u NONE -N"
alias tmux="tmux attach -d || tmux"
alias ag="ag -S --pager='less -R'"
alias trans-ej='trans {en=ja}'
alias trans-je='trans {ja=en}'
alias gr='cd $(git root)'
alias repo='cd $(ghq list -p | fzf --ansi)'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.intpurc ]; then
  . ~/.inputrc
fi

if [ -f ~/.bashrc.functions ]; then
  . ~/.bashrc.functions
fi

export PROMPT_COMMAND='history -a; history -r'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1

PS1='[\[\033[0;36m\]\u\[\033[0m\] \[\033[0;33m\]\W\[\033[0m\]$(__git_ps1 " \[\033[0;32m\](%s)\[\033[0m\]")]\$ '
