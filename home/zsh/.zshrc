if [ -z $WSL_INTEROP ]; then
	# Path to your oh-my-zsh installation.
	export ZSH="/home/caleb/.oh-my-zsh"

	# Which plugins would you like to load?
	plugins=(git fast-syntax-highlighting)

	source $ZSH/oh-my-zsh.sh
fi

# User configuration
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/caleb/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

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
[ -z $WSL_INTEROP ] && alias ls='ls -hN --color=never --group-directories-first'
