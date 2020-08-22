#!/usr/bin/env zsh

# Will be read when starting as a login shell
# Used to autostart graphical sessions and set session-wide environment variables

# Autostart X at login
#if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#	exec startx
#fi
