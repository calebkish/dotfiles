#!/usr/bin/env sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -merge ~/.Xresources
remaps
killall redshift 2>/dev/null ; redshift &
# killall picom 2>/dev/null ; picom --experimental-backends --config ~/.config/picom/picom.conf &
killall unclutter 2>/dev/null ; unclutter --timeout 2 &

if [ -e "$HOME/.screenlayout/layout.sh" ]; then
    ~/.screenlayout/layout.sh
fi

# Will replace TTY shell process with awesome process
exec awesome
