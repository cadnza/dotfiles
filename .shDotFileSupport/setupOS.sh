# Group OSs
osMacos="darwin"
osLinux="linux bsd"
osWindows="cygwin msys"
osOther="solaris haiku"

# Define function for OS matching
isOSmatch() {
	ptrn="("$(echo $1 | sed 's/ /\|/g')")"
	if [[ $(echo $OSTYPE | grep -Pci "$ptrn") -gt 0 ]]
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
elif [[ $(isOSmatch $osMacos) = 1 ]]
then
	# Set machine prompt color
	colorMachine=7
	# Enable syntax highlighting
	source $(brew --prefix 2> /dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zshs 2> /dev/null || {
		showZshInstallInstructions "brew install zsh-syntax-highlighting"
	}
elif [[ $(isOSmatch $osLinux) = 1 ]]
then
	# Set machine prompt color
	colorMachine=green
	# Enable syntax highlighting
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "sudo apt-get install zsh-syntax-highlighting"
	}
elif [[ $(isOSmatch $osWindows) = 1 ]]
then
	# Set machine prompt color
	colorMachine= #208
	# Enable syntax highlighting
	echo "NOTE: zsh-syntax-highlighting isn't available for Windows yet, so syntax highlighting is disabled."
	# Add Git Bash SDK to path to give Git for Windows' zsh access to Git Bash's functions
	export PATH=/c/git-sdk-64/usr/bin:$PATH
elif [[ $(isOSmatch $osOther) = 1 ]]
then
	# Set machine prompt color
	colorMachine=7 #TEMP
fi

# Add aliases for non-macos machines
if [[ $(isOSmatch $osMacos) = 0 ]]
then
	alias ls="ls --color"
	alias gtimeout="timeout"
fi
