#!/usr/bin/env sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -merge ~/.Xresources
remaps
killall picom 2>/dev/null ; picom --config ~/.config/picom/picom.conf &
killall unclutter 2>/dev/null ; unclutter --timeout 2 &

# Will replace TTY shell process with awesome process
exec awesome
