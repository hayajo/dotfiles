# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.intpurc ]; then
	. ~/.inputrc
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

