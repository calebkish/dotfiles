#!/usr/bin/env zsh

# This file should not assume shell is attached to a TTY
# This file will always be read

export NVM_DIR="$HOME/.nvm"
export DEFAULT_NODE_VERSION="v16.14.2"
export NVM_BIN="$NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/bin"

# -U option: For arrays, keep only the first occurrence of each duplicated value
typeset -U PATH path
path=(
    "$HOME/.local/bin"
    "$HOME/.luarocks/bin"
    "$HOME/.local/user-bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/npm-bin/node_modules/.bin"
    "$NVM_BIN"
    "$path[@]"
)
export PATH

export OPENER="xdg-open"
export EDITOR="nvim"
export PAGER="less"

export LESSHISTFILE="-" # Disable less history file
export TERM="xterm-256color"
export DOTNET_CLI_TELEMETRY_OPTOUT="1"
export GTK_THEME="Adwaita:dark"

export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/caleb/.luarocks/share/lua/5.4/?.lua;/home/caleb/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/lib/lua/5.4/?.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/caleb/.luarocks/lib/lua/5.4/?.so'
