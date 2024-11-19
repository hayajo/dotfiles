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
    export HOMEBREW_NO_AUTO_UPDATE=1
    test -x "/opt/homebrew/bin/brew" && {
        # Homebrew の環境変数を設定する
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # asdf の環境変数を設定する
        ASDF_PREFIX=$(brew --prefix asdf)
        test -d "$ASDF_PREFIX" && . "$ASDF_PREFIX/libexec/asdf.sh"

        # coreutils の libexec/gnubin を PATH に追加する
        COREUTILS_PREFIX=$(brew --prefix coreutils)
        test -d "$COREUTILS_PREFIX" && export PATH="$COREUTILS_PREFIX/libexec/gnubin:$PATH"
    }
}

: "Setup krew" && {
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
}

: "Configure PATH" && {
    # [ -d "$(go env GOPATH)" ] && PATH="$(go env GOPATH)/bin:$PATH" # Go のパスを追加する
    type krew &>/dev/null && PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # krew のパスを追加する
    PATH="$HOME/bin:$PATH" # 自作スクリプトのパスを追加する
    export PATH
}

: "Startup" && {
    # ssh-agent が起動していない場合は起動する
    test -z "$SSH_AUTH_SOCK" && eval "$(ssh-agent)"
}

: "Setup nodenv" && {
    type nodenv &>/dev/null && {
        eval "$(nodenv init - bash)"
    }
}

: "Load .bashrc" && {
    # .bashrc が存在する場合は読み込む
    test -r "$HOME/.bashrc" && . "$HOME/.bashrc"
    # .bashrc.local が存在する場合は読み込む
    test -r "$HOME/.bashrc.local" && . "$HOME/.bashrc.local"
}
