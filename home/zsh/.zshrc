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
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

alias ls='ls -hN --color=always --group-directories-first'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias bc="bc -l"

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

remove_from_path() {
    path_fragment="$1"
    path_fragment_index=${path[(i)$path_fragment]}
    path[$path_fragment_index]=()
}

NVM_DIR="$HOME/.nvm"
load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

DEFAULT_NODE_VERSION="v16.16.0"
NVM_BIN="$NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/bin"
PATH="$NVM_BIN:$PATH"
alias nvm="
echo 'Please wait while nvm loads'
remove_from_path $NVM_BIN
unset NVM_BIN
unalias nvm
load_nvm
nvm $@"

install-nvim-deps() {
    if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
        git clone --depth 1 https://github.com/wbthomason/packer.nvim \
            ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    fi

    # Python, HTML, CSS, JS, TS, JSON, Docker, TailwindCSS
    if [ ! -d "$HOME/.local/npm-bin" ]; then
        (
            mkdir -p ~/.local/npm-bin
            cd ~/.local/npm-bin &&
            npm install \
                pyright \
                dockerfile-language-server-nodejs \
                typescript-language-server \
                vscode-langservers-extracted \
                @tailwindcss/language-server
        )
    fi

    # C#
    if [ ! -e "$HOME/.local/omnisharp/run" ]; then
        (
            rm -r ~/.local/omnisharp 2>/dev/null
            mkdir -p ~/.local/omnisharp 2>/dev/null
            REPO="https://github.com/OmniSharp/omnisharp-roslyn.git"
            LATEST=$(git -c 'versionsort.suffix=-' \
                ls-remote --exit-code --refs --sort='version:refname' --tags $REPO '*.*.*' \
                | tail --lines=1 \
                | cut --delimiter='/' --fields=3)
            FILE="omnisharp-linux-x64-net6.0.tar.gz"
            cd ~/.local/omnisharp &&
            wget "https://github.com/Omnisharp/omnisharp-roslyn/releases/download/$LATEST/$FILE" 1>/dev/null &&
            untar "$FILE" 1>/dev/null
        )
    fi

    # Lua
    if [ ! -e "$HOME/.local/lua-language-server/bin/lua-language-server" ]; then
        (
            rm -r ~/.local/lua-language-server 2>/dev/null
            mkdir -p ~/.local/lua-language-server 2>/dev/null
            REPO="https://github.com/sumneko/lua-language-server.git"
            LATEST=$(git -c 'versionsort.suffix=-' \
                ls-remote --exit-code --refs --sort='version:refname' --tags $REPO '*.*.*' \
                | tail --lines=1 \
                | cut --delimiter='/' --fields=3)
            FILE="lua-language-server-$LATEST-linux-x64.tar.gz"
            cd ~/.local/lua-language-server &&
            wget "https://github.com/sumneko/lua-language-server/releases/download/$LATEST/$FILE" 1>/dev/null &&
            untar "$FILE" 1>/dev/null
        )
    fi

    # netcoredbg
    if [ ! -e "$HOME/.local/dap-adapters/netcoredbg" ]; then
        (
            rm -r ~/.local/dap-adapters/netcoredbg 2>/dev/null
            mkdir -p ~/.local/dap-adapters/netcoredbg 2>/dev/null
            REPO="https://github.com/Samsung/netcoredbg.git"
            LATEST=$(git -c 'versionsort.suffix=-' \
                ls-remote --exit-code --refs --sort='version:refname' --tags $REPO '*.*.*' \
                | tail --lines=1 \
                | cut --delimiter='/' --fields=3)
            FILE="netcoredbg-linux-amd64.tar.gz"
            cd ~/.local/dap-adapters/netcoredbg &&
                wget "https://github.com/Samsung/netcoredbg/releases/download/$LATEST/$FILE" 1>/dev/null &&
                untar "$FILE" 1>/dev/null
        )
    fi
}

install-tmux-deps() {
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        mkdir -p ~/.tmux/plugins/tpm
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
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

if [ ! -d "$HOME/.nvm" ]; then
    (
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    )
fi
# if [ ! -d "$HOME/.asdf" ]; then
#     (
#         REPO="https://github.com/asdf-vm/asdf.git"
#         LATEST=$(git -c 'versionsort.suffix=-' \
#             ls-remote --exit-code --refs --sort='version:refname' --tags $REPO '*.*.*' \
#                 | tail --lines=1 \
#                 | cut --delimiter='/' --fields=3)
#         git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$LATEST"
#     )
#
# fi
# . $HOME/.asdf/asdf.sh

# asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git

# asdf list all PLUGIN_NAME
# aset install PLUGIN_NAME VERSION
# aset global PLUGIN_NAME VERSION
