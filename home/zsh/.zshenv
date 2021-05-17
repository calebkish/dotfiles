#/usr/bin/env zsh

# This file should not assume shell is attached to a TTY
# This file will always be read

typeset -U PATH path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" "$path[@]")
export PATH

# Disable less history file
export LESSHISTFILE=-

export EDITOR="nvim"

[ -z $WSL_INTEROP ] && systemctl --user import-environment PATH
