#!/usr/bin/env sh
tmux ls -F "#{session_created} #S" | sort | cut -d" " -f2 | nl -s " " -w1 | grep "^$1" | cut -d" " -f2 | xargs tmux switch-client -t
