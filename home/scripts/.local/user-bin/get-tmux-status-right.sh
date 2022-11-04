#!/usr/bin/env sh
tmux ls -F "#{session_created} #S #[fg=#default]#{?session_attached,#[fg=cyan]#S#[fg=default],#S}" | sort | cut -d" " -f3 | nl -s ":" -w1 | tr "\\n" " "
