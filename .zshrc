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

# Enable syntax highlighting from Homebrew zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Run prompt setup
source ~/.shDotFileSupport/prompt.sh

# Run color setup
source ~/.shDotFileSupport/colors.sh
