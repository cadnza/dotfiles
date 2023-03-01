#!/usr/false

# Enable op completion if op is installed
eval "$(op completion zsh 2> /dev/null)" &> /dev/null
compdef _op op &> /dev/null
