#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

: "Load /etc/bashrc" && {
  test -r /etc/bashrc && . /etc/bashrc
}

function vscode {
    { test $# -eq 1 && test -n "$1"; } || return
    VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$@"
}

: "Set keybinds" && {
    # Ctrl+w をファイル名に基づく単語削除に変更する
    stty werase undef
    bind '"\C-w": unix-filename-rubout'
}

: "Define Aiases" && {
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
    alias v='vscode "$(ghq list -p | fzf --ansi)"'

    alias temp='cd "$(mktemp -d -p ~/Desktop)"'
    alias t='cd "$(find ~/Desktop -maxdepth 1 -type d -name "tmp.*" | fzf --ansi)"'
}

: "Setup Completions" && {
    # ~/.bash_profile でロードしても有効になるのはログインシェルだけなので ~/.bashrc でロードしている
    # SEE ALSO: https://docs.brew.sh/Shell-Completion#configuring-completions-in-bash
    BASH_COMPLETION="$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    test -r "$BASH_COMPLETION" && . "$BASH_COMPLETION"

    # なぜか git の completion だけロードされないので個別にロードする
    GIT_PREFIX=$(brew --prefix git)
    if [ -d "$GIT_PREFIX" ]; then
        . "$GIT_PREFIX/etc/bash_completion.d/git-completion.bash"
        . "$GIT_PREFIX/etc/bash_completion.d/git-prompt.sh"
    fi
}

# プロンプトを設定する
: "Setup Prompt" && {
    __ps1=""

    # git のブランチ名を表示する
    if type __git_ps1 &>/dev/null; then
        export PROMPT_DIRTRIM=2
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWUPSTREAM=1
        export GIT_PS1_SHOWUNTRACKEDFILES=
        export GIT_PS1_SHOWSTASHSTATE=1

        # shellcheck disable=SC2016
        __ps1=${__ps1}'\[\e[00;33m\]$(__git_ps1)'
    fi

    # kubectl のコンテキスト名を表示する
    type kubectl &>/dev/null && kubectl config current-context &>/dev/null 2>&1 && {
        # shellcheck disable=SC2016
        __ps1='\[\e[04;31m\]($(kubectl config current-context))'${__ps1}
    }

    # プロンプトを設定する
    # NOTE: tmux でプロンプトを検索しやすいように、プロンプトと入力の間を U+00a0 (NO-BREAK SPACE) にする
    export PS1=${__ps1}' \[\e[01;34m\]\w \$ \[\e[m\]'
}

: "Setup fzf" && {
    # インタラクティブシェルでのみ fzf を有効にする
    type fzf &>/dev/null && [[ $- == *i* ]] && {
        eval "$(fzf --bash)"
        export FZF_DEFAULT_OPTS="--height 40% --border --color=dark"
        # NOTE: for >= 0.36.0
        export RUNEWIDTH_EASTASIAN=0
    }
}

: "Setup direnv" && {
    type direnv &>/dev/null && {
        eval "$(direnv hook bash)"
    }
}

# : "Setup Docker" && {
    # # docker の環境は lima で構築する。インスタンス名は default とする。
    # export DOCKER_HOST=unix://$HOME/.lima/default/sock/docker.sock
    # # docker で実行するアーキテクチャは x86_64 とする
    # # NOTE: lima を vmType = vz (= aarch64) として構築しているため、指定しないと docker のイメージも aarch64 になってしまう
    # # export DOCKER_DEFAULT_PLATFORM=linux/amd64
# }
