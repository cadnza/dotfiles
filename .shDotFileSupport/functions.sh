#!/usr/bin/env zsh

# Go to the top level of a Git repo
gd() {
	root=$(git rev-parse --show-toplevel) 2> /dev/null || {
		echo -e "\033[32mgd\033[0m only works inside a Git repo."
		return
	}
	cd $root
}

# Quite Apple Terminal on exiting the last window
[ "$TERM_PROGRAM" = "Apple_Terminal" ] && {
	exit() {

		# Exit normally if in screen session
		[ -n $STY ] && builtin exit "$@"

		# Exit normally if in anything other than base Apple Terminal
		# (checking here too to spare non- Apple Terminal emulators from having to define the alias)
		[ "$TERM_PROGRAM" = "Apple_Terminal" ] || builtin exit "$@"

		# Run Applescript for checking Apple Terminal windows and closing the application
		screen -d -m $HOME/.shDotFileSupport/scripts/quitAppleTerminal.sh

		# Exit normally
		builtin exit "$@"
	}
}
