# Note optional files
# .hushdiff silences git buffer diff indicators. This can speed things up on a machine with large repos.

# Set zsh-newuser-install settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt nomatch
bindkey -e

# Set compinstall reference
zstyle :compinstall filename '~/.zshrc'

# Run color setup
source ~/.shDotFileSupport/colors.sh

# Run settings per OS
source ~/.shDotFileSupport/setupOS.sh

# Run completion settings
source ~/.shDotFileSupport/completion.sh

# Set default text editor
export EDITOR=nano

# Modify path
source ~/.shDotFileSupport/path.sh

# Set aliases
source ~/.shDotFileSupport/aliases.sh

# Source functions
source ~/.shDotFileSupport/functions.sh

# Run prompt setup
source ~/.shDotFileSupport/prompt.sh
