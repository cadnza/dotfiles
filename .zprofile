# Set up Tecuity computer
if [ "$HOST" == "$TECUITY" ];
then
	
	# Recognize HomeBrew
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# End setting up Tecuity computer
fi

# Add R to path
export PATH=$PATH:/Library/Frameworks/R.framework/Resources/bin/

# Add sbin to path
export PATH=/usr/local/sbin:$PATH

# Add ~/bin to path for symlinks
export PATH=~/bin:$PATH

# Import variables
source ~/.shDotFileSupport/variables.sh
