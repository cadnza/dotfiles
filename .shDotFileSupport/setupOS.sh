# Group OSs
osMacos="darwin"
osLinux="linux bsd"
osWindows="cygwin msys"

# Define function for OS matching
isOSmatch() {
	ptrn="("$(echo $1 | sed 's/ /\|/g')")"
	if [[ $(echo $OSTYPE | LC_ALL=en_US.utf8 grep -Eci "$ptrn") -gt 0 ]]
	then
		echo 1
	else
		echo 0
	fi
}

# Get function to show for zsh-syntax-highlighting install instructions
showZshInstallInstructions() {
	cmd=$1
	echo "To enable syntax highlighting, run \`$1\` and start a new shell."
}

# Configure settings per OS
if [[ 1 = 0 ]]; then # Dead line to avoid preferential treatment in if block
# macos
elif [[ $(isOSmatch $osMacos) = 1 ]]
then
	# Set machine prompt color
	colorMachine=$colorMacos
	# Enable syntax highlighting
	source $(brew --prefix 2> /dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "brew install zsh-syntax-highlighting"
	}
# Linux
elif [[ $(isOSmatch $osLinux) = 1 ]]
then
	# Set machine prompt color
	colorMachine=$colorLinux
	# Enable syntax highlighting
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "sudo apt-get install zsh-syntax-highlighting"
	}
# Windows
elif [[ $(isOSmatch $osWindows) = 1 ]]
then
	# Set machine prompt color
	colorMachine=$colorWindows
	# Enable command to enable zsh-syntax-highlighting
	source ~/.shDotFileSupport/zshSyntaxHighlightingPull.sh
	# Add Git Bash SDK to path to give Git for Windows' zsh access to Git Bash's functions
	export PATH=/c/git-sdk-64/usr/bin:$PATH
# Other
else
	# Set machine prompt color
	colorMachine=$colorOther
	# Enable command to enable zsh-syntax-highlighting
	source ~/.shDotFileSupport/zshSyntaxHighlightingPull.sh
fi

# Add aliases for non-macos machines
if [[ $(isOSmatch $osMacos) = 0 ]]
then
	alias ls="ls --color"
	alias gtimeout="timeout"
fi
