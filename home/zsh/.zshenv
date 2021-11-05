#/usr/bin/env zsh

# This file should not assume shell is attached to a TTY
# This file will always be read

typeset -U PATH path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.local/npm-bin/node_modules/.bin" "$path[@]")
export PATH

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
