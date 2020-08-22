#/usr/bin/env zsh

# This file should not assume shell is attached to a TTY
# This file will always be read

typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

systemctl --user import-environment PATH
