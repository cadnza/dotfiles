# Set up Tecuity computer
if [ "$HOST" = "TEC-DEV34-WK" ];
then
	source ~/.shDotFileSupport/setupTecuity.sh
fi

# Add R to path
export PATH=$PATH:/Library/Frameworks/R.framework/Resources/bin/

# Add sbin to path
export PATH=/usr/local/sbin:$PATH

# Add ~/bin to path for symlinks
export PATH=~/bin:$PATH

echo Testing
