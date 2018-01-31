# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

if [ -f ~/.intpurc ]; then
	. ~/.inputrc
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
