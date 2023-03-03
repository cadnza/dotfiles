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

# Modify path
source $HOME/.support/path.sh

# Source functions
source $HOME/.support/functions.sh

# Run color setup
source $HOME/.support/colors.sh

# Run settings per OS
source $HOME/.support/setupOS.sh # Currently profiling on EngineRoom at ~0.08s

# Run completion settings
source $HOME/.support/completion.sh # Currently profiling on EngineRoom at ~0.11s

# Set default text editor
export VISUAL=micro
export EDITOR=micro
git config --global core.editor nano

# Display banners
source $HOME/.support/banners.sh

# Run prompt setup
source $HOME/.support/prompt.sh

# Source commands for Secure ShellFish
source $HOME/.support/shellfishrc.sh

# Initialize shell integration if running in VS Code
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)" || trap
