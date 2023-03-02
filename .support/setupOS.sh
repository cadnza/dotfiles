#!/usr/bin/env false

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
workingOSfileName=.dotfilesOS
workingOSfile=$HOME/$workingOSfileName
workingOS=$(cat $workingOSfile) 2> /dev/null || {
	workingOS="$(tryOSmatch $osMacos)$(tryOSmatch $osLinux)$(tryOSmatch $osWindows)"
	echo $workingOS > $workingOSfile
}

# Get function to show for zsh-syntax-highlighting install instructions
showZshInstallInstructions() {
	cmd=$1
	echo "To enable syntax highlighting, run \`$1\` and start a new shell."
}

# Configure settings per OS
if [[ 1 = 0 ]]; then # Dead line to avoid preferential treatment in if block
# macos
elif [[ $workingOS = $osMacos ]]
then
	# Set machine prompt color
	export colorMachine=$colorMacos
	# Enable syntax highlighting
	source $(brew --prefix 2> /dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "brew install zsh-syntax-highlighting"
	}
	# Check for light mode
	[ $TERM_PROGRAM = Apple_Terminal ] && {
		[ $(defaults read -g AppleInterfaceStyle &> /dev/null; echo $?) = 0 ] || export isDarkMode=0
	}
# Linux
elif [[ $workingOS = $osLinux ]]
then
	# Set machine prompt color
	export colorMachine=$colorLinux
	# Enable syntax highlighting
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || {
		showZshInstallInstructions "sudo apt install zsh-syntax-highlighting"
	}
# Windows
elif [[ $workingOS = $osWindows ]]
then
	# Set machine prompt color
	export colorMachine=$colorWindows
	# Enable command to enable zsh-syntax-highlighting
	source $HOME/.support/zshSyntaxHighlightingPull.sh
	# Make sure /usr/bin is first in path
	export PATH=/usr/bin:$PATH
# Other
else
	# Set machine prompt color
	export colorMachine=$colorOther
	# Enable command to enable zsh-syntax-highlighting
	source $HOME/.support/zshSyntaxHighlightingPull.sh
fi

# Add aliases for non-macos machines
if [[ $workingOS != $osMacos ]]
then
	alias ls="ls --color=auto"
	alias gtimeout="timeout"
fi
