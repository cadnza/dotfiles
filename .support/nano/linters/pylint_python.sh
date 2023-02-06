#!/usr/bin/env zsh

# This script seems useless, but for whatever reason there's an error invoking
# pylint as a linter in nano without some kind of wrapper.

pylint $1
exit 0
