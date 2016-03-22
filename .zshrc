# -*- mode: zsh -*-
# vi: set ft=zsh foldmethod=marker:

# init
# {{{
: ${OS:=linux}

case "$OSTYPE" in
  darwin*)
    OS=darwin
    ;;
  freebsd*)
    OS=freebsd
    ;;
  windows*)
    OS=windows
    ;;
esac
# }}}

# options
# {{{
setopt auto_cd
setopt auto_param_slash
setopt auto_pushd
# setopt complete_aliases
setopt correct
setopt extended_glob
setopt extended_history
setopt glob_complete
setopt hist_expand
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt inc_append_history
setopt interactivecomments
setopt list_packed
setopt list_rows_first
setopt list_types
setopt long_list_jobs
setopt magic_equal_subst
setopt mark_dirs
setopt multios
setopt no_beep
# setopt noclobber
setopt nolistbeep
setopt numeric_glob_sort
setopt path_dirs
setopt print_eightbit
setopt print_exit_value
unsetopt promptcr
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent
setopt share_history

stty stop undef
# }}}

# history
# {{{
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# }}}

# completion
# {{{
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# add ssh_hosts
[ -f ~/.ssh/config ] && _cache_hosts=(`perl -ne 'print "$1 " if(/^Host\s+(.+)$/)' ~/.ssh/config`)
# }}}

# prompt
# {{{
case ${UID} in
    0)
        PROMPT="%F{green}%*%f [%F{red}%n%f %F{yellow}%c%f]# "
        PROMPT2="%_ # "
        ;;
    *)
        PROMPT="%F{green}%*%f [%F{cyan}%n%f %F{yellow}%c%f]$ "
        PROMPT2="%_ $ "
        ;;
esac

SPROMPT="%B%F{red}%r%f%b is correct? [n,y,a,e]: "
# }}}

# keybinds
# {{{
bindkey -e
bindkey "[3~" delete-char

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
# }}}

# word-style
# {{{
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "*?_-.[]~=/&;!#$%^(){}<> "
zstyle ':zle:*' word-style unspecified
# }}}

# alias
# {{{
case "$OS" in
  freebsd|darwin)
    alias ls="ls -G -w"
    ;;
  linux)
    alias ls="ls --color=auto"
    alias pbcopy="xsel --clipboard --input"
    alias open="xdg-open"
    ;;
esac

alias tmux='tmux attach -d || tmux'
alias dpkg='COLUMNS=${COLUMNS:-80} dpkg'

alias ipl='perl -de1'
alias cpanm-installdeps='cpanm -Llocal --installdeps'
alias cpanm-exec='perl -Mlib::core::only -Mlib=local/lib/perl5'

alias ag='ag -S --pager="less -R"'

alias vi=vim

alias ssh='cat ~/.ssh/config.d/* > ~/.ssh/config; ssh'
# }}}

# function
# {{{
if [[ -f "$HOME/.zshrc.function" ]]; then
  source "$HOME/.zshrc.function"
fi
# }}}

# path
# {{{
if [ -z "$TMUX" ]; then
  export PATH=$HOME/local/bin:$HOME/bin::$PATH
  export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
fi
# }}}

# env
# {{{
umask 022

export EDITOR='vi'
export LANG='ja_JP.UTF-8'
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'
# }}}

# external rc
if [[ -f "$HOME/.zshrc.$OS" ]]; then
  source "$HOME/.zshrc.$OS"
fi

if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
