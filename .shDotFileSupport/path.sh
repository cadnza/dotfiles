#!/usr/bin/env zsh

# Add sbin to path
export PATH=/usr/local/sbin:$PATH

# Add user binaries to path
export PATH=$HOME/bin:$PATH

# Add nano linter and formatter directories to path
export PATH=$HOME/.shDotFileSupport/nano/linters:$PATH
export PATH=$HOME/.shDotFileSupport/nano/formatters:$PATH
