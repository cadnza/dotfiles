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

# Run color setup
source ~/.shDotFileSupport/colors.sh

# Run settings per OS
source ~/.shDotFileSupport/setupOS.sh

# Modify path
source ~/.shDotFileSupport/path.sh

# Set aliases
source ~/.shDotFileSupport/aliases.sh

# Source functions
source ~/.shDotFileSupport/functions.sh

# Run prompt setup
source ~/.shDotFileSupport/prompt.sh
