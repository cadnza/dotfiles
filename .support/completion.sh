#!/usr/bin/env zsh

# Generate completions from commands with zsh-specific completion generation
addCompletions bookmarks "--generate-completion-script zsh"

# Initialize completion
fpath=($HOME/Repos/dotfiles/.support/completion_functions_dynamic $fpath)
autoload -Uz compinit
compinit

# Enable completion menu selector
zstyle ':completion:*' menu select
bindkey '\e[Z' reverse-menu-complete # Shift tab

# Match completion colors to LS colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} $(echo "ma=38;5;0;48;5;$colorMachine;1")

# Source completions
find $HOME/.support/completion_scripts -type f | while read -r f
do
	source $f
done
