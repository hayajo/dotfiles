# zshrc

autoload -Uz colors
colors

# 環境変数 {{{
export LANG='ja_JP.UTF-8'
# }}}

# 履歴 {{{
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# }}}

# キーバインド {{{
bindkey -e # emacs風キーバインドにする
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
# }}}

# 単語の区切り文字を設定する {{{
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "*?_-.[]~=/&;!#$%^(){}<> "
zstyle ':zle:*' word-style unspecified
# }}}

# 補完を有効にする {{{
autoload -Uz compinit
compinit
## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
## sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
## ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# }}}

# プロンプト表示 {{{
PROMPT='%F{green}%*%f [%F{cyan}%n%f %F{yellow}%c%f]$ '
# }}}

# オプション {{{
setopt no_beep # ビープを無効にする
setopt interactive_comments # '#'以降をコメントとする
setopt auto_param_slash # ディレクトリ名の補完で末尾に'/'を付加する
setopt auto_cd # ディレクトリ名だけでcdする
setopt auto_pushd # 自動的にpushdする
setopt pushd_ignore_dups # 重複したディレクトリをpushdしない
setopt magic_equal_subst # '='の後はパス名として補完する
#setopt nonomatch # ワイルドカードの補完に失敗してもエラーとせずコマンド引数として渡す
setopt extended_history # 履歴に開始時刻、終了時刻が記載する
setopt inc_append_history # 入力後直ちに履歴に登録する
setopt share_history # zsh間で履歴を共有する
setopt hist_ignore_all_dups # 重複したコマンドを履歴に残さない
setopt hist_save_nodups # 重複するコマンドがあったら古い方を削除する
setopt hist_ignore_space # スペースから始まるコマンドは履歴に残さない
setopt hist_reduce_blanks # 履歴保存時に不要な空白を削除する
setopt extended_glob # 高機能なワイルドカード展開を使用する
setopt print_eight_bit # 日本語ファイル名を表示可能にする
# }}}

# alias {{{
alias ls="ls -lGF"
alias tmux="tmux attach -d || tmux"
alias ag="ag -S --pager='less -R'"
alias vi="vim -u NONE -N"
alias gr='cd $(git root)'
# }}}

# PATH {{{
export PATH=$HOME/bin:$PATH

# direnv
which direnv >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
  eval "$(direnv hook zsh)"
fi

# docker-machine
if [[ -z "$DOCKER_HOST" ]]; then
  eval "$(docker-machine env default)"
fi

# gplang
if [[ -z "$GOPATH" ]]; then
  export GOPATH=$HOME
  export PATH="$(brew --prefix go):$PATH"
fi

## plenv
if [[ -z "$PLENV_HOME" ]]; then
  export PLENV_HOME="$HOME/.plenv"
  eval "$(plenv init -)"
fi

## rbenv
if [[ -z "$RBENV_HOME" ]]; then
  export RBENV_HOME="$HOME/.rbenv"
  eval "$(rbenv init -)"
fi

## pyenv
if [[ -z "$PYENV_HOME" ]]; then
  export PYENV_HOME="$HOME/.pyenv"
  eval "$(pyenv init -)"
fi

## nodenv
if [[ -z "$NODENV_HOME" ]]; then
  export NODENV_HOME="$HOME/.nodenv"
  eval "$(nodenv init -)"
fi


# }}}

# 外部設定ファイルのロード {{{
## ゴミ箱
if [[ -f ~/.zshrc.trash ]]; then
  source ~/.zshrc.trash
fi

## vcs_info
if [[ -f ~/.zshrc.vcs_info ]]; then
  source ~/.zshrc.vcs_info
fi

## OS固有の設定
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
if [[ -f ~/.zshrc.$OS ]]; then
  source ~/.zshrc.$OS
fi

## ローカル設定
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
# }}}

# vim: ft=zsh
# vim: foldmethod=marker
# vim: foldmarker={{{,}}}
