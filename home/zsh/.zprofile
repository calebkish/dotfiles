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
    export AWS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
    export NODE_EXTRA_CA_CERTS="/etc/ssl/certs/ca-certificates.crt"
    export SSL_CERT_DIR="/etc/ssl/certs"
    export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"

    export DISPLAY="$(cat /etc/resolv.conf | grep 'nameserver' | awk '{print $2}'):0"
    wsl.exe -d wsl-vpnkit service wsl-vpnkit start 2>/dev/null
fi

