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
		[ -n $STY ] || builtin exit "$@"

		# Exit normally if in anything other than base Apple Terminal, e.g. tmux
		# (checking here too to spare non- Apple Terminal emulators from having to define the alias)
		[ "$TERM_PROGRAM" = "Apple_Terminal" ] || builtin exit "$@"

		# Run Applescript for checking Apple Terminal windows and closing the application
		screen -d -m $HOME/.support/scripts/quitAppleTerminal.sh

		# Exit normally
		builtin exit "$@"
	}
}

# Add or update completions
addCompletions() {

	# Name constants
	commandName=$1
	argsGenerateCompletion=$2

	# Exit if command isn't found
	which $commandName &> /dev/null || return

	# Set file constants
	dirCompletions=$HOME/.support/completion_functions
	fileName="_$commandName"
	fileFinal="$dirCompletions/$fileName"

	# Generate directory if it doesn't exist
	[[ -d $dirCompletions ]] || mkdir $dirCompletions

	# Get old version
	[[ -f $fileFinal ]] && {
		versionOld=$(tail -n 1 $fileFinal)
	} || {
		versionOld=""
	}

	# Get current version
	commandVersion="$commandName --version"
	versionCurrent="#"$(eval ${commandVersion})

	# Exit if version hasn't changed
	[[ $versionCurrent = $versionOld ]] && return

	# Generate completion script
	commandScript="$commandName $argsGenerateCompletion"
	eval ${commandScript} > $fileFinal

	# Tack on version number
	commandVersion="$commandName --version"
	echo $versionCurrent >> $fileFinal

}
