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

## Alias ls-like commands for color
alias ls="ls -G"
alias dir="dir -G"
alias vdir="vdir -G"
alias grep="grep -G"
alias fgrep="fgrep -G"
alias egrep="egrep -G"
