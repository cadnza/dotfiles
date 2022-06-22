#!/usr/bin/env zsh

# Initialize completion
autoload -Uz compinit
compinit

# Enable completion menu selector
zstyle ':completion:*' menu select
bindkey '\e[Z' reverse-menu-complete # Shift tab

# Match completion colors to LS colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} $(echo "ma=38;5;0;48;5;$colorMachine;1")

# Enable op completion if op is installed
eval "$(op completion zsh 2> /dev/null)" &> /dev/null
compdef _op op &> /dev/null

# Enable completion for gcloud
compsgcloud="$HOME/.google-cloud-sdk/completion.zsh.inc"
[ -f $compsgcloud ] && source $compsgcloud
