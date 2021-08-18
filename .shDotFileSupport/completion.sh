#!/usr/bin/env zsh

# Initialize completion
autoload -Uz compinit
compinit

# Enable completion menu selector
zstyle ':completion:*' menu select
bindkey '\e[Z' reverse-menu-complete # Shift tab

# Match completion colors to LS colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}