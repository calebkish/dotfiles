#!/usr/bin/env zsh

# User configuration
HISTFILE=~/.histfile
HISTSIZE=50
SAVEHIST=50
unsetopt beep
bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/caleb/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Enable colors and change prompt:
autoload -U colors && colors    # Load colors
# setopt autocd       # Automatically cd into typed directory.
stty stop undef     # Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
# bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

alias ls='ls -hN --color=always --group-directories-first'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ll='ls -al'
alias untar='tar -zxvf'

alias ae="source venv/bin/activate"
alias de="deactivate"
alias ce="python3 -m venv venv"
alias ie="pip install --upgrade pip ; pip3 install -r requirements.txt"

alias ng="npm run ng"

PROMPT='%B%1~%f %#%b '

# if [ -z $WSL_INTEROP -a -z $WSLENV -a -z $WSL_DISTRO_NAME ]; then
#     true
# else
#     # [ -n "$(pwd | grep /mnt/c/Users/)" ] && cd
# fi


# Git clone bare
gcb() {
    repo="$1"
    plug_dir_name="${repo##*/}"
    plug_dir_name="${plug_dir_name%%.git}"
    git clone $repo --bare "$plug_dir_name/.git"
}


install-nvim-deps() {
    # Python, HTML, CSS, JS, TS, JSON, Docker
    (
        mkdir -p ~/.local/npm-bin
        cd ~/.local/npm-bin
        npm install \
            pyright \
            dockerfile-language-server-nodejs \
            typescript-language-server \
            vscode-langservers-extracted
    )


    # C#
    if [ ! -d "$HOME/.local/omnisharp" ]; then
        (
            mkdir -p ~/.local/omnisharp
            cd ~/.local/omnisharp
            REPO="OmniSharp/omnisharp-roslyn"
            LATEST_RELEASE="$(gh release -R $REPO list | grep 'Latest' | awk '{print $1}')"
            FILE="omnisharp-linux-x64.tar.gz"
            gh release -R $REPO download $LATEST_RELEASE --pattern "$FILE"
            untar "$FILE"
        )
    fi


    # Lua
    if [ ! -d "$HOME/.local/lua-language-server" ]; then
        (
            mkdir -p ~/.local/lua-language-server
            cd ~/.local/lua-language-server
            REPO="sumneko/lua-language-server"
            LATEST_RELEASE="$(gh release -R $REPO list | grep 'Latest' | awk '{print $1}')"
            FILE="lua-language-server-$LATEST_RELEASE-linux-x64.tar.gz"
            gh release -R $REPO download $LATEST_RELEASE --pattern "$FILE"
            untar "$FILE"
        )
    fi
}

install-tmux-deps() {
    mkdir -p ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install-zsh-plugins() {
    plugin_repos="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    mkdir -p ~/.zplugins

    echo "$plugin_repos" | tr " " "\n" | while read repo; do
        (
            cd ~/.zplugins
            plug_dir_name="${repo##*/}"
            plug_dir_name="${plug_dir_name%%.git}"
            git clone "$repo"
            git -C "$HOME/.zplugins/$plug_dir_name" pull origin master
        )
    done
}

source ~/.zplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

if [ ! -d "$HOME/.asdf" ]; then
    (
        REPO="asdf-vm/asdf"
        LATEST_RELEASE="$(gh release -R $REPO list | grep 'Latest' | awk '{print $1}')"
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$LATEST_RELEASE"
    )

fi
. $HOME/.asdf/asdf.sh

# asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
# asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git

# asdf list all PLUGIN_NAME
# aset install PLUGIN_NAME VERSION
# aset global PLUGIN_NAME VERSION
