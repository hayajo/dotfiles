#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

# macOS の警告文を表示しない
export BASH_SILENCE_DEPRECATION_WARNING=1

: "Configure Histroy" && {
    # 複数行にまたがったコマンドを1行のヒストリに保存する
    shopt -s cmdhist
    # ヒストリに同じコマンドを連続して保存しない
    export HISTCONTROL=ignoredups:erasedups
    # ヒストリに保存するコマンド数を増やす
    export HISTSIZE=100000
    # ヒストリファイルに保存するコマンド数を増やす
    export HISTFILESIZE=100000

    # ヒストリファイルに保存する際に重複を削除する
    shopt -u histappend
    export PROMPT_COMMAND="history -a; history -c; history -r"
}

: "Setup Homebrew" && {
    # Homebrew の環境変数を設定する
    [ -x "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

    # asdf の環境変数を設定する
    ASDF_PREFIX=$(brew --prefix asdf)
    if [ -d "$ASDF_PREFIX" ]; then
        . "$ASDF_PREFIX/libexec/asdf.sh"
        . "$ASDF_PREFIX/etc/bash_completion.d/asdf.bash"
    fi

    # git の環境変数を設定する
    GIT_PREFIX=$(brew --prefix git)
    test -d "$GIT_PREFIX" && export GIT_PREFIX

    # fzf の環境変数を設定する
    FZF_PREFIX=$(brew --prefix fzf)
    test -d "$FZF_PREFIX" && export FZF_PREFIX

    DIRENV_PREFIX=$(brew --prefix direnv)
    test -d "$DIRENV_PREFIX" && export DIRENV_PREFIX

    # coreutils の libexec/gnubin を PATH に追加する
    COREUTILS_PREFIX=$(brew --prefix coreutils)
    test -d "$COREUTILS_PREFIX" && export PATH="$COREUTILS_PREFIX/libexec/gnubin:$PATH"
}

: "Configure PATH" && {
    # [ -d "$(go env GOPATH)" ] && PATH="$(go env GOPATH)/bin:$PATH" # Go のパスを追加する
    PATH="$HOME/bin:$PATH" # 自作スクリプトのパスを追加する
    export PATH
}

: "Startup" && {
    # ssh-agent が起動していない場合は起動する
    [ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent)"
}

: "Load .bashrc" && {
    # .bashrc が存在する場合は読み込む
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
    # .bashrc.local が存在する場合は読み込む
    [ -f "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"
}
