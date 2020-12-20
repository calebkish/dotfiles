#/usr/bin/env zsh

# This file should not assume shell is attached to a TTY
# This file will always be read

typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CACHE_HOME="$HOME/.cache"
#export XDG_CONFIG_HOME="$home/.config"

# Disable less history file
export LESSHISTFILE=-

systemctl --user import-environment PATH
