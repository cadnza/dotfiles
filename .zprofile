# Add R to path
export PATH=$PATH:/Library/Frameworks/R.framework/Resources/bin/

# Add sbin to path
export PATH=/usr/local/sbin:$PATH

# Add ~/.symlinks to path for symlinks
export PATH=~/.symlinks:$PATH

# Set aliases

## Alias R for radian
alias R="radian"

# Echo something
CLR='\033[0m'
NCLR='\033[0m' # No Color
BLD=$(tput bold)
NBLD=$(tput sgr0)
#echo -e "${CLR}${BLD}Ready?${NBLD}${NCLR}" # Commented out for compatibility
