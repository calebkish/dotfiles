#!/usr/bin/env zsh

# This file should not assume shell is attached to a TTY
# This file will always be read

typeset -U PATH path
path=("$HOME/.local/user-bin" "$HOME/.cargo/bin" "$HOME/.local/npm-bin/node_modules/.bin" "$path[@]")
export PATH

export OPENER="xdg-open"
export EDITOR="nvim"
export PAGER="less"

