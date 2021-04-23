# Recognize HomeBrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Alias cd and start at Windows home directory
TECDIR="/mnt/c/Users/jon.dayley/"
HOME="$TECDIR" cd
alias cd="HOME=$TECDIR cd"
