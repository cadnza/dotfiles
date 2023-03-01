#!/usr/bin/env false

# Record reference to temporary directory containing repo
fileZshSynHighRef=$HOME/.zshSyntaxHighlightingDirectoryReference

# Get function to create a temporary directory and record its location
getAndRecordTempDir() {
	hDir=$(mktemp -d)
	echo $hDir > "$fileZshSynHighRef"
	echo $hDir
}

# Create a new temporary directory with reference if the ref or dir doesn't exist
export HIGHLIGHTING_DIRECTORY=$(cat $fileZshSynHighRef 2> /dev/null || getAndRecordTempDir)
ls $HIGHLIGHTING_DIRECTORY &> /dev/null || export HIGHLIGHTING_DIRECTORY=$(getAndRecordTempDir)

# Identify target script
target=$HIGHLIGHTING_DIRECTORY/zsh-syntax-highlighting.zsh

# Source target script or make highlight function available on failure
source $target 2> /dev/null || {
	# Echo messages
	echo "NOTE: zsh-syntax-highlighting isn't available as a package for $OS yet."
	echo -e "You can source it directly from the repo by running \e[32mhighlight\e[0m, which will"
	echo "enable syntax highlighting until the computer's temporary files are cleared."
	# Define highlight function
	highlight() {
		# Return if highlighting is already enabled
		if [[ -n "$ZSH_HIGHLIGHT_VERSION" ]]
		then
			echo "You already have zsh-syntax-highlighting enabled."
			return
		fi
		# Source target script or clone and source on failure
		source $target 2> /dev/null || {
			echo "Cloning repo..."
			zshSyntaxHighlightingURL=https://github.com/zsh-users/zsh-syntax-highlighting.git
			git clone $zshSyntaxHighlightingURL $HIGHLIGHTING_DIRECTORY
			echo "Enabling highlighting..."
			source $target
			echo "Finishing..."
			rm -rf "$HIGHLIGHTING_DIRECTORY/.git"
			echo "Done!"
		}
	}
}
