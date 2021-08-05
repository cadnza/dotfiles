# Group OSs
osMacos="darwin"
osLinux="linux bsd"
osWindows="cygwin msys"

# Define function for OS matching
tryOSmatch() {
	ptrn="("$(echo $1 | sed 's/ /\|/g')")"
	if [[ $(echo $OSTYPE | LC_ALL=en_US.utf8 grep -Eci "$ptrn") -gt 0 ]]
	then
		echo $1
	else
		echo ""
	fi
}

# Record OS string for fast checking
workingOSfileName=.com.jondayley.shDotFilesOS.txt
workingOSfile=~/$workingOSfileName
workingOS=$(cat $workingOSfile) 2> /dev/null || {
	workingOS="$(tryOSmatch $osMacos)$(tryOSmatch $osLinux)$(tryOSmatch $osWindows)"
	echo $workingOS > $workingOSfile
}

# Get function to show for zsh-syntax-highlighting install instructions
showZshInstallInstructions() {
	cmd=$1
	echo "To enable syntax highlighting, run \`$1\` and start a new shell."
}

# Set default for using git diff indicators
osUseDiffIndicator=true

# Configure settings per OS
if [[ 1 = 0 ]]; then # Dead line to avoid preferential treatment in if block
# macos
elif [[ $workingOS = $osMacos ]]
then
	# Set machine prompt color
	colorMachine=$colorMacos
	# Enable syntax highlighting
	source $(brew --prefix 2> /dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "brew install zsh-syntax-highlighting"
	}
# Linux
elif [[ $workingOS = $osLinux ]]
then
	# Set machine prompt color
	colorMachine=$colorLinux
	# Enable syntax highlighting
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "sudo apt-get install zsh-syntax-highlighting"
	}
# Windows
elif [[ $workingOS = $osWindows ]]
then
	# Set machine prompt color
	colorMachine=$colorWindows
	# Enable command to enable zsh-syntax-highlighting
	source ~/.shDotFileSupport/zshSyntaxHighlightingPull.sh
	# Add Git Bash SDK to path to give Git for Windows' zsh access to Git Bash's functions
	export PATH=/c/git-sdk-64/usr/bin:$PATH
	# Disable git diff indicators
	osUseDiffIndicator=false
# Other
else
	# Set machine prompt color
	colorMachine=$colorOther
	# Enable command to enable zsh-syntax-highlighting
	source ~/.shDotFileSupport/zshSyntaxHighlightingPull.sh
fi

# Add aliases for non-macos machines
if [[ $workingOS = $osMacos ]]
then
	alias ls="ls --color"
	alias gtimeout="timeout"
fi
