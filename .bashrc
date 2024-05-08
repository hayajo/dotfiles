#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

[ -f /etc/bashrc ] && source /etc/bashrc

: "Configure keybinds" && {
    # Ctrl+w をファイル名に基づく単語削除に変更する
    stty werase undef
    bind '"\C-w": unix-filename-rubout'
}

: "Set Aiases" && {
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    alias ls='ls -FG --color'
    alias diff='diff --color'
    alias tmux="tmux attach -d || tmux"
    alias ag="ag -S --pager='less -R'"

    alias v="view"
    alias vi="vim -u NONE -N"
    alias e='edit'
    alias edit='vim'

    alias g='git'
    alias d='docker'
    alias k='kubectl'
    alias kx='kubectl ctx'

    alias r='cd "$(ghq list -p | fzf --ansi)"'
    alias v='VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$(ghq list -p | fzf --ansi)"'

    alias temp='cd "$(mktemp -d -p ~/Desktop)"'
    alias t='cd "$(find ~/Desktop -maxdepth 1 -type d -name "tmp.*" | fzf --ansi)"'
}

# プロンプトを設定する
: "Configure Prompt" && {
    __appends=""

    # Homebrew の bash_completion を読み込む
    BASH_COMPLETION="${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    test -r "$BASH_COMPLETION" && . "$BASH_COMPLETION"

    # git のブランチ名を表示する
    test -n "$GIT_PREFIX" && {
        export PROMPT_DIRTRIM=2
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWUPSTREAM=1
        export GIT_PS1_SHOWUNTRACKEDFILES=
        export GIT_PS1_SHOWSTASHSTATE=1

        . "$GIT_PREFIX/etc/bash_completion.d/git-completion.bash"
        . "$GIT_PREFIX/etc/bash_completion.d/git-prompt.sh"

        # shellcheck disable=SC2016
        __appends=${__appends}'\[\e[00;33m\]$(__git_ps1)'
    }

    # kubectl のコンテキスト名を表示する
    which kubectl >/dev/null && kubectl config current-context >/dev/null 2>&1 && {
        # shellcheck disable=SC2016
        __appends='\[\e[04;31m\]($(kubectl config current-context))'${__appends}
    }

    # プロンプトを設定する
    # NOTE: tmux でプロンプトを検索しやすいように、プロンプトと入力の間を U+00a0 (NO-BREAK SPACE) にする
    export PS1=${__appends}' \[\e[01;34m\]\w \$ \[\e[m\]'
}

: "Setup fzf" && {
    # インタラクティブシェルでのみ fzf を有効にする
    test -n "$FZF_PREFIX" && [[ $- == *i* ]] || return
    eval "$(fzf --bash)"
    export FZF_DEFAULT_OPTS="--height 40% --border --color=dark"
    # NOTE: for >= 0.36.0
    export RUNEWIDTH_EASTASIAN=0
}

: "Setup direnv" && {
    test -n "$DIRENV_PREFIX" || return
    eval "$(direnv hook bash)"
}
