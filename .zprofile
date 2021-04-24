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

# Set aliases

## Alias nano for softwrapping
alias nano="nano -S"

# Echo something
CLR='\033[0m'
NCLR='\033[0m' # No Color
BLD=$(tput bold)
NBLD=$(tput sgr0)
echo -e "${CLR}${BLD}Ready?${NBLD}${NCLR}"
