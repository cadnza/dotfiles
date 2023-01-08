#!/usr/bin/env zsh

# Add sbin to path
export PATH=/usr/local/sbin:$PATH

# Add user binaries to path
export PATH=$HOME/bin:$PATH

# Add included executables to path
export PATH=$HOME/.shDotFileSupport/executables:$PATH

# Add hidden local to path (needed for some executables)
export PATH=$HOME/.local/bin:$PATH

# Add nano linter and formatter directories to path
export PATH=$HOME/.shDotFileSupport/nano/linters:$PATH
export PATH=$HOME/.shDotFileSupport/nano/formatters:$PATH

# Add pub to path (for Flutter)
export PATH=$PATH:$HOME/.pub-cache/bin

# Add gcloud to path
export PATH=$PATH:$HOME/.google-cloud-sdk/bin

# Add local homebrew path and source eval script
export PATH=$PATH:$HOME/.homebrew/bin
[ -d $HOME/.homebrew ] && eval "$($HOME/.homebrew/bin/brew shellenv)"

# Add lsregister location to path (for finding URI schemes)
# You can list registered URI scheme bindings with `lsregister -dump URLSchemeBinding`.
# Optionally throw on a `| sort` to sort the output.
export PATH=$PATH:/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/
