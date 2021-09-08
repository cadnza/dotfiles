#/usr/bin/env zsh

# Format Python ignoring indentation
formatted=$(autopep8 --ignore=E101,E11 $1)
echo "$formatted" > $1

# Exit
exit 0
