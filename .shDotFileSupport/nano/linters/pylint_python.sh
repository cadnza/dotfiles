#!/usr/bin/env zsh

# Filter formatting messages
pylint $1 | grep "[0-9]: "

# Exit
exit 0
