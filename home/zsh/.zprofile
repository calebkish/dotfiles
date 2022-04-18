#!/usr/bin/env zsh

# Will be read when starting as a login shell
# Used to autostart graphical sessions and set session-wide environment variables

# Autostart X at login
# if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#     exec startx
# fi

if [ -z $WSL_INTEROP -a -z $WSLENV -a -z $WSL_DISTRO_NAME ]; then
    # Make sure PATH environment variable is set for systemd services
    systemctl --user import-environment PATH
else
    export SSL_CERT_DIR="/home/caleb/certificates/"
    export SSL_CERT_FILE="/home/caleb/certificates/ql-combined-certificate.crt"
    export NODE_EXTRA_CA_CERTS="$HOME/certificates/ql-combined-certificate.crt"
    wsl.exe -d wsl-vpnkit service wsl-vpnkit start 2>/dev/null
fi
