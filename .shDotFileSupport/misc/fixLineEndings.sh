#!/usr/bin/env zsh

# Go to shDotFiles directory
cd $(git -C $(dirname $0) rev-parse --show-toplevel)

# Get currently untracked files
currentlyUntrackeds=$(git ls-files --others --exclude-standard)

# Get standard list of files
fixQueue="$(/usr/bin/find . -regex '\.\/\.[A-z0-9]+$')\n$(/usr/bin/find -name "*.sh")"

# Start progress bar
echo -ne "\r#"

# Open loop through shell files
echo $fixQueue | while read -r singleFile
do

	# Fix line endings
	[[ -f $singleFile ]] && dos2unix $singleFile 2> /dev/null

	echo -ne '\b##'

# Close loop
done
