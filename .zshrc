# Note optional files
# .hushdiff silences git buffer diff indicators. This can speed things up on a machine with large repos.

# Source local scripts
[[ -f $HOME/.localrc ]] && source $HOME/.localrc

# Set zsh-newuser-install settings
HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt nomatch
bindkey -e

# Set compinstall reference
zstyle :compinstall filename $HOME/.zshrc

# Run color setup
source $HOME/.shDotFileSupport/colors.sh

# Run settings per OS
source $HOME/.shDotFileSupport/setupOS.sh # Currently profiling on EngineRoom at ~0.08s

# Run completion settings
source $HOME/.shDotFileSupport/completion.sh # Currently profiling on EngineRoom at ~0.11s

# Set default text editor
export VISUAL=micro
export EDITOR=micro
git config --global core.editor nano

# Modify path
source $HOME/.shDotFileSupport/path.sh

# Source functions
source $HOME/.shDotFileSupport/functions.sh

# Display banners
source $HOME/.shDotFileSupport/banners.sh

# Run prompt setup
source $HOME/.shDotFileSupport/prompt.sh

# Source commands for Secure ShellFish
source $HOME/.shDotFileSupport/shellfishrc.sh

# Initialize shell integration if running in VS Code
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
