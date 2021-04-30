# Set zsh-newuser-install settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt nomatch
bindkey -e

# Set compinstall settings
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

# Modify path

## Add R to path
export PATH=$PATH:/Library/Frameworks/R.framework/Resources/bin/

## Add sbin to path
export PATH=/usr/local/sbin:$PATH

## Add ~/.symlinks to path for symlinks
export PATH=~/.symlinks:$PATH

# Set aliases

## Alias R for radian
alias R="radian"

# Source functions
for f in $(ls ~/.shDotFileSupport/functions)
do
	eval "source ~/.shDotFileSupport/functions/$f"
done

# Enable syntax highlighting from Homebrew zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Run prompt setup
source ~/.shDotFileSupport/prompt.sh

# Run color setup
source ~/.shDotFileSupport/colors.sh
