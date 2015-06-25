#====================
# env
#====================

export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'
export LV="-c -i"

umask 022

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

#====================
# options
#====================

setopt auto_cd
setopt auto_param_slash
setopt auto_pushd
# setopt complete_aliases
setopt correct
setopt glob_complete
setopt hist_no_store
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
setopt extended_glob

stty stop undef

#====================
# preexec
#====================

# for screen
preexec () {
    # !! in screen, window 0 don't have $WINDOW !!
    if [ $TERM = "xterm-256color" -a $WINDOW ]; then
        1="$1 " # deprecated with space.
        # !! zsh array is started from 1 !!
        echo -ne "\ek${${(s: :)1}[1]}\e\\"
    fi
    export TERM="xterm-256color"
}

#====================
# completion
#====================

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

#====================
# history
#====================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt extended_history
setopt hist_expand
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

#====================
# prompt
#====================

# 太字-01  下線-04  点滅-05  配色反転-07  非表示-08
# ノーマル化-22 下線なし-24 点滅なし-25 配色反転なし-27
# 文字色 黒-30 赤-31 緑-32 黄-33 青-34 紫-35 水-36 白-37
# 背景色 黒-40 赤-41 緑-42 黄-43 青-44 紫-45 水-46 白-47
# ref : http://gihyo.jp/dev/serial/01/zsh-book/0003
local DEFAULT=$'%{\e[m%}'
local RED=$'%{\e[31m%}'
local GREEN=$'%{\e[32m%}'
local CYAN=$'%{\e[36m%}'
local MAGENTA=$'%{\e[35m%}'

case ${UID} in
    0)
        PROMPT="%B${GREEN}[%*] ${RED}%n${DEFAULT}%b@%m %~"$'\n'"%c# "
        PROMPT2="%_ # "
        SPROMPT="'%B${RED}%r${DEFAULT}%b' is correct? [n,y,a,e]: "
        ;;
    *)
        PROMPT="%B${GREEN}[%*] ${CYAN}%n${DEFAULT}%b@%m %~"$'\n'"%c$ "
        PROMPT2="%_ $ "
        SPROMPT="'%B${RED}%r${DEFAULT}%b' is correct? [n,y,a,e]: "
        ;;
esac

#====================
# keybinds
#====================

bindkey -e
bindkey "[3~" delete-char

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# http://d.hatena.ne.jp/kei_q/20110308/1299594629
function show_buffer_stack() {
    POSTDISPLAY="
stack: $LBUFFER"
    zle push-line
}
zle -N show_buffer_stack
bindkey "^[q" show_buffer_stack

#====================
# word-style
#====================

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "*?_-.[]~=/&;!#$%^(){}<> "
zstyle ':zle:*' word-style unspecified

#====================
# vcs (git, svn, etc.)
#====================

RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz colors

# 以下の3つのメッセージをエクスポートする
#   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
#   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
#   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git svn hg bzr
# 標準のフォーマット(git 以外で使用)
# misc(%m) は通常は空文字列に置き換えられる
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true


if is-at-least 4.3.10; then
    # git 用のフォーマット
    # git のときはステージしているかどうかを表示
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
    zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列
fi

# hooks 設定
if is-at-least 4.3.11; then
    # git のときはフック関数を設定する

    # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    # のメッセージを設定する直前のフック関数
    # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
    # 各関数が最大3回呼び出される。
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-push-status \
                                            git-nomerge-branch \
                                            git-stash-count

    # フックの最初の関数
    # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
    # (.git ディレクトリ内にいるときは呼び出さない)
    # .git ディレクトリ内では git status --porcelain などがエラーになるため
    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # 0以外を返すとそれ以降のフック関数は呼び出されない
            return 1
        fi

        return 0
    }

    # untracked フィアル表示
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # unstaged (%u) に ? を表示
    function +vi-git-untracked() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # unstaged (%u) に追加
            hook_com[unstaged]+='?'
        fi
    }

    # push していないコミットの件数表示
    #
    # リモートリポジトリに push していないコミットの件数を
    # pN という形式で misc (%m) に表示する
    function +vi-git-push-status() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        # if [[ "${hook_com[branch]}" != "master" ]]; then
            # # master ブランチでない場合は何もしない
            # return 0
        # fi

        # push していないコミット数を取得する
        local ahead
        # ahead=$(command git rev-list origin/master..master 2>/dev/null \
        ahead=$(command git rev-list origin/${hook_com[branch]}..${hook_com[branch]} 2>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ "$ahead" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # マージしていない件数表示
    #
    # master 以外のブランチにいる場合に、
    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
    # (mN) という形式で misc (%m) に表示
    function +vi-git-nomerge-branch() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # master ブランチの場合は何もしない
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "$nomerged" -gt 0 ]] ; then
            # misc (%m) に追加
            hook_com[misc]+="(m${nomerged})"
        fi
    }


    # stash 件数表示
    #
    # stash している場合は :SN という形式で misc (%m) に表示
    function +vi-git-stash-count() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+=":S${stash}"
        fi
    }

fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=""
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    RPROMPT="$prompt"
}
add-zsh-hook precmd _update_vcs_info_msg

#====================
# functions
#====================

# print all history
function history-all { history -E 1 }

# trash
TRASHDIR=~/.trash
del () {
    local path
    for path in "$@"; do
        # ignore any arguments
        if [[ "$path" = -* ]]; then
            echo "del doesn't understand any arguments. Should use /bin/rm."
            return
        else
            # create trash if necessary
            if [ ! -d $TRASHDIR ]; then
                /bin/mkdir -p $TRASHDIR
            fi

            local dst=${path##*/}
            # append the time if necessary
            while [ -e $TRASHDIR"/$dst" ]; do
                dst="$dst $(/bin/date +%H-%M-%S)"
            done
            /bin/mv "$path" $TRASHDIR/"$dst"
        fi
    done
}

# # 新年の抱負
# newyear_resolution () {
    # echo -e "$1年の抱負: \e[35m $2\e[0m\n"
# }
# newyear_resolution 2014 不言実行

# プログラミング原則
programming_rules () {
  echo -e "\e[1mPrinciples of Programming\e[0m\n"
  while read line; do
    echo "$line"
  done <<"EOM"
\        \\e[01m\\e[35mKISS\\e[0m Keep It Simple, Stupid.
\       \\e[01m\\e[35mYAGNI\\e[0m You Aren't Going to Need It.
\         \\e[01m\\e[35mDRY\\e[0m Don't Repeat Yourself.
\    \\e[01m\\e[35mSTFUAWSC\\e[0m Shut the fuck up and write some code!
\    \\e[01m\\e[35m三大美徳\\e[0m 怠慢(Laziness)、短気(Impatience)、傲慢(Hubris)
\\\e[01m\\e[35mデザイン原則\\e[0m 近接、整列、反復、コントラスト
EOM
    echo -e "\n... and have fun!\n"
}
programming_rules

#====================
# z
#====================
if [ -f ~/z.sh ]; then
    touch ~/.z
    source ~/z.sh
    function precmd () {
        _z --add "$(pwd -P)"
    }
fi

#====================
# git-flow-completion
#====================
if [ -f ~/.git-flow-completion.zsh ]; then
    source ~/.git-flow-completion.zsh
fi

#====================
# ssh-agent
#====================
SSH_AGENT_FILE="$HOME/.ssh-agent-info"
test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE
if ! ssh-add -l >& /dev/null ; then
  ssh-agent > $SSH_AGENT_FILE
  source $SSH_AGENT_FILE
  ssh-add
fi

#====================
# alias
#====================

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w"
        ;;
    linux*)
        alias ls="ls --color=auto"
        alias pbcopy="xsel --clipboard --input"
        alias open="xdg-open"
        ;;
esac

alias screen='screen -D -RR'
alias tmux='tmux attach -d || tmux'

alias dpkg='COLUMNS=${COLUMNS:-80} dpkg'

alias rm='del'
alias trash-look="ls -al $TRASHDIR/ 2> /dev/null"
alias trash-clean="/bin/rm -R -f $TRASHDIR/(*|.*)"
alias clean=trash-clean

alias cpanm-installdeps='cpanm -Llocal --installdeps'
alias cpanm-exec='perl -Mlib::core::only -Mlib=local/lib/perl5'

alias ipl='perl -de1'
alias ag='ag -S --pager="less -R"'

alias git-root='git rev-parse && cd `git rev-parse --show-toplevel`'

alias vi=vim

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
