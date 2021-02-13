#/usr/bin/env zsh

# This file should not assume shell is attached to a TTY
# This file will always be read

typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

# Disable less history file
export LESSHISTFILE=-

export EDITOR="nvim"

# Set where python virtual environments should be stored.
# Used by virtualenvwrapper (pip install virtualenvwrapper)
export WORKON_HOME="~/.virtualenvs"
source /usr/bin/virtualenvwrapper.sh

systemctl --user import-environment PATH
