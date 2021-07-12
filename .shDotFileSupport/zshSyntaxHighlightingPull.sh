echo "NOTE: zsh-syntax-highlighting isn't available as a package for $OS yet,"
echo -e "but you can source the script directly from the repo by running \e[32mhighlight\e[0m."

highlight() {
	if [[ $alreadyHighlighted = 1 ]]
	then
		echo "You've already enabled zsh-syntax-highlighting."
		return
	fi
	tempDir=$(mktemp -d)
	echo "Cloning repo..."
	zshSyntaxHighlightingURL=https://github.com/zsh-users/zsh-syntax-highlighting.git
	git clone $zshSyntaxHighlightingURL $tempDir
	echo "Enabling highlighting..."
	source $tempDir/zsh-syntax-highlighting.zsh
	echo "Removing repo..."
	rm -rf $tempDir
	echo "Done!"
	export alreadyHighlighted=1
}
