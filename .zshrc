# shellcheck disable=SC1090

# Source environment variables
source "$HOME/.support/env.sh"

# Source local logic
f_localrc="$HOME/.localrc"
[ -f "$f_localrc" ] && source "$f_localrc"

# Set zsh-newuser-install settings
export HISTFILE=$HOME/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
unsetopt nomatch
bindkey -e

# Set compinstall reference
zstyle :compinstall filename "$HOME/.zshrc"

# Modify path
source "$HOME/.support/path.sh"

# Run color setup
source "$HOME/.support/colors.sh"

# Run settings per OS
source "$HOME/.support/setup_os.sh" # Currently profiling on EngineRoom at ~0.08s

# Run completion settings
source "$HOME/.support/completion.sh" # Currently profiling on EngineRoom at ~0.11s

# Set default text editor
export VISUAL=nano
export EDITOR=nano
git config --global core.editor nano

# Display banners
source "$HOME/.support/banners.sh"

# Run prompt setup
source "$HOME/.support/prompt.sh"

# Source commands for Secure ShellFish
source "$HOME/.support/.shellfishrc"

# Initialize shell integration if running in VS Code
[ "$TERM_PROGRAM" == "vscode" ] && . "$(code --locate-shell-integration-path zsh)"

# Source 1Password plugins
f_op_plugins="$HOME/.config/op/plugins.sh"
[ -f "$f_op_plugins" ] && source "$f_op_plugins"
