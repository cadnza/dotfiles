# Set zsh-newuser-install settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt nomatch
bindkey -e

# Set compinstall settings
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

# Modify path
source ~/.shDotFileSupport/path.sh

# Set aliases
source ~/.shDotFileSupport/aliases.sh

# Source functions
funcs=$(ls ~/.shDotFileSupport/functions 2> /dev/null)
if [[ `echo $funcs | grep \S+ | wc -l` -gt 0 ]];
then
	for f in $funcs
	do
		eval "source ~/.shDotFileSupport/functions/$f"
	done
else
	echo "No functions sourced. You'll find them in ~/.shDotFileSupport/functions."
fi

# Enable syntax highlighting from Homebrew zsh-syntax-highlighting
if [[ `which brew | grep "brew not found" | wc -l` -ge 1 ]]; then
	echo "Homebrew isn't installed for $USERNAME, so syntax highlighting is disabled."
	echo "To enable syntax highlighting, please do the following:"
	echo " 1. Install Homebrew"
	echo " 2. Run \`brew install zsh-syntax-highlighting\`"
	echo " 3. Source .zshrc"
else
	source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Run prompt setup
source ~/.shDotFileSupport/prompt.sh

# Run color setup
source ~/.shDotFileSupport/colors.sh

# Run setup for work machine
if [[ $COMPUTERNAME = "TEC-DEV34-WK" ]]
then
	source ~/.shDotFileSupport/work.sh
fi
