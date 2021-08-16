#!/usr/bin/env zsh

# Start a job with a unique ID in a screen and
# disallow jobs of the same ID until it finishes;
# Good for hardcoded commands, e.g. in iOS Shortcuts
function screenStartJob {
	ID="${1/\./}" # Disallow . character
	ID=ID | xargs # Trim whitespace
	CT=$(
		screen -ls | \
			grep "^\t" | \
			cut -f 2 | \
			cut -f 2 -d . | \
			grep $ID -F | \
			grep "" -c
	)
	CT=$(($CT + 0))
	if [ $CT -ge 1 ]
	then
		echo "There is already a screen called $1."
	else
		CMD="screen -S $ID -dm $2"
		eval $CMD
	fi
}

# Go to the top level of a Git repo
gd() {
	root=$(git rev-parse --show-toplevel) 2> /dev/null || {
		echo -e "\e[32mgd\e[0m only works inside a Git repo."
		return
	}
	cd $root
}
