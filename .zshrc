# Set zsh-newuser-install settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt nomatch
bindkey -e

# Set compinstall settings
zstyle :compinstall filename '/Users/cadenza/.zshrc'
autoload -Uz compinit
compinit

# Enable syntax highlighting from Homebrew zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# alias cd and start at target directory
if [ $HOSTNAME == "TEC-DEV34-WK" ]
then
	alias cd="HOME=/mnt/c/Users/jon.dayley/ cd"
	cd
fi
