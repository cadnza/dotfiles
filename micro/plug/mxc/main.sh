#!/usr/bin/env sh

# Get function to run script if executable
runScript() {
	[[ -x $1 ]] && {
		echo "\033[1;36m$1\033[0m"
		$1
		exit 0
	} || {
		echo "\033[1;31m$1 is not executable.\033[0m"
		exit 126
	}
}

# Get function to run target script if in target directory
runTarget() {
	tDirectory=$1/$t
	[[ -f $1/$t ]] && runScript $tDirectory
}

# Get original file
f=$(readlink -n $1)
[[ -f $f ]] || f=$1

# Set name of target script to run
t=".mxc"

# Get file directory
d=$(dirname $f)

# Run script if in file directory
runTarget $d

# Check for target script in each directory along repo if directory is a git repo
dRepo=$(git rev-parse --show-toplevel 2> /dev/null)
[[ $? = 0 ]] && {
	while [[ $d != $dRepo ]]
	do
		d=$(dirname $d)
		runTarget $d
	done
}

# Run original file on fallback
runScript $f
