#!/usr/bin/env zsh

# Will be read when starting as a login shell
# Used to autostart graphical sessions and set session-wide environment variables

# Autostart X at login
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi


# Disable less history file
export LESSHISTFILE=-

export EDITOR="nvim"
export TERM="xterm-256color"

export DOTNET_CLI_TELEMETRY_OPTOUT="1"

if [ -z $WSL_INTEROP -a -z $WSLENV -a -z $WSL_DISTRO_NAME ]; then
    systemctl --user import-environment PATH
    export JAVA_HOME="/usr/lib/jvm/default"
else
    export SSL_CERT_DIR="/home/caleb/certificates/"
    export SSL_CERT_FILE="/home/caleb/certificates/ql-combined-certificate.crt"
    export NODE_EXTRA_CA_CERTS="$HOME/certificates/ql-combined-certificate.crt"
fi

