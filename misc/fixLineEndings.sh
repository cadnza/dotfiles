# Verify that we're in the shDotFiles directory
if [[ $(basename $PWD) = "shDotFiles" ]]
then

	# Get currently untracked files
	currentlyUntrackeds=$(git ls-files --others --exclude-standard)

	# Get standard list of files
	fixQueue="$(find . -regex '\.\/\.[A-z0-9]+$')\n$(find -name "*.sh")"

	# Start progress bar
	echo -ne "\r#"

	# Open loop through shell files
	echo $fixQueue | while read -r singleFile
	do

		# Set whether to stage file after fixing line endings based on whether it already had changes
		doStage=1
		echo $currentlyUntrackeds | while read -r currentlyUntracked
		do
			[[ $currentlyUntracked -ef $singleFile ]] && doStage=0
		done

		# Fix line endings
		[[ -f $singleFile ]] && dos2unix $singleFile 2> /dev/null

		# Stage file if it didn't have any changes before
		[[ $doStage = 1 ]] && git add $singleFile 2> /dev/null

		echo -ne '\b##'

	# Close loop
	done

# Error if not in shDotFiles directory
else
	echo "Please run this script from the shDotFiles directory."
fi
