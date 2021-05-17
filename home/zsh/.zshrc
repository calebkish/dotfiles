# User configuration
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

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
bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

alias ls='ls -hN --color=always --group-directories-first'
alias ll='ls -al'
alias lt='ls --human-readable --size -1 -S --classify'
alias untar='tar -zxvf'
alias cl='clear'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias mkd='mkdir -pv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ae="source venv/bin/activate"
alias de="deactivate"
alias ce="python3 -m venv venv"
alias ie="pip install --upgrade pip ; pip3 install -r requirements.txt"

PROMPT='%B%1~%f %#%b '

[ -n "$(pwd | grep /mnt/c/Users/)" ] && cd


plugin_repos="git@github.com:zsh-users/zsh-syntax-highlighting.git"
[ ! -d '~/.zplugins' ] && mkdir ~/.zplugins 2>/dev/null

echo "$plugin_repos" | tr ' ' '\n' | while read repo; do
	(
		cd ~/.zplugins
		plug_dir_name="${repo##*/}"
		plug_dir_name="${plug_dir_name%%.git}"
		git clone "$repo" 2>/dev/null
		#git -C "$HOME/.zplugins/$plug_dir_name" pull origin master 1>/dev/null 2>&1
	)
done

source ~/.zplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
