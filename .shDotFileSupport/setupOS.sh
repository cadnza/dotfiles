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
elif [[ $(isOSmatch $osMacos) -gt 0 ]]
then
	# Set machine prompt color
	# Enable syntax highlighting
	source $(brew --prefix 2> /dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zshs 2> /dev/null || {
		showZshInstallInstructions "brew install zsh-syntax-highlighting"
	}
elif [[ $(isOSmatch $osLinux) = 1 ]]
then
	# Set machine prompt color
	# Enable syntax highlighting
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "sudo apt-get install zsh-syntax-highlighting"
	}
elif [[ $(isOSmatch $osWindows) -gt 0 ]]
then
	# Set machine prompt color
elif [[ $(isOSmatch $osOther) -gt 0 ]]
then
	# Set machine prompt color
fi
