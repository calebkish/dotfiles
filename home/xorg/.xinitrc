#!/usr/bin/env sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -merge ~/.Xresources
remaps &
compton --config ~/.config/compton/compton.conf &
unclutter --timeout 2 &
systemctl --user start user-applications.target
exec awesome
