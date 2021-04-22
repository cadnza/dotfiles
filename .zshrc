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

# Set prompt
PROMPT="%n@%m %1~ %# "

# Import variables
source ~/.shDotFileSupport/variables.sh

# Enable syntax highlighting from Homebrew zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up Tecuity computer
if [ "$HOST" == "$TECUITY" ];
then
	
	## Alias cd and start at Windows home directory
	TECDIR="/mnt/c/Users/jon.dayley/"
	HOME="$TECDIR" cd
	alias cd="HOME=$TECDIR cd"

# End setting up Tecuity computer
fi
