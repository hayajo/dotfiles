#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC1091

# DEBUG
echo "[DEBUG] eval zprofile"

eval "$(/opt/homebrew/bin/brew shellenv)"

FZF_PREFIX="$(brew --prefix fzf)" && export FZF_PREFIX
export RUNEWIDTH_EASTASIAN=0 # for fzf >= 0.36.0

export PROMPT_DIRTRIM=2
