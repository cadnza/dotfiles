#!/usr/bin/env zsh

# Add sbin to path
export PATH=/usr/local/sbin:$PATH

# Add user binaries to path
export PATH=$HOME/bin:$PATH

# Add dotfile support directory to path (mostly for nano linters and formatters)
export PATH=$HOME/.shDotFileSupport:$PATH
