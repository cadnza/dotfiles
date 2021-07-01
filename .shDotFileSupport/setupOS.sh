# Group OSs
osMacos="darwin"
osLinux="
linux
bsd
"
osWindows="
cygwin
msys
"
osOther="
solaris
haiku
"

# Define function for OS matching
isOSmatch() {
	if [[ $(echo $1 | grep -c -i $OSTYPE) -gt 0 ]]
	then
		echo true
	else
		echo ""
	fi
}

# Configure settings per OS
if [[ 1 = 0 ]]; then # Dead line to avoid preferential treatment in if block
elif [[ $(isOSmatch $osMacos) -gt 0 ]]
	# Set machine prompt color
	# Enable syntax highlighting
then
elif [[ $(isOSmatch $osLinux) -gt 0 ]]
	# Set machine prompt color
	# Enable syntax highlighting
then
elif [[ $(isOSmatch $osWindows) -gt 0 ]]
	# Set machine prompt color
	# Enable syntax highlighting
then
elif [[ $(isOSmatch $osOther) -gt 0 ]]
	# Set machine prompt color
	# Enable syntax highlighting
then
fi
