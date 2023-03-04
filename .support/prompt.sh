#!/usr/bin/env false

# Run patch to speed up git completion
# (I currently don't understand how this works. I'm pending reading into the zsh completion system, but that's not a priority right now.)
# The fix comes from here:
#     https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off#9810485
__git_files () {
	_wanted files expl 'local files' _files
}

# Source chosen prompt
promptFile="$HOME/.prompt"
promptsDir="$HOME/.support/prompts"
basicPrompt="$promptsDir/basic.sh"
[ -f $promptFile ] && {
	themeName=$(cat $promptFile | head -n 1)
	themeFile="$promptsDir/$themeName.sh"
	[ -f $themeFile ] && source $themeFile || source $basicPrompt
} || source $basicPrompt

# Set right prompt VCS options
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'

# Get function to decide whether to show git diff indicators by timeout
decideByTimeout() {
	inner() {
		delay=0.15
		gtimeout $delay zsh -fc "{
			git status &> /dev/null;
			echo true;
		}"
		echo false
	}
	enable=$(echo $(inner) | cut -d " " -f 1)
	echo $enable
}

# Get function to decide whether to show git diff indicators by reported repo size
decideBySize() {
	threshold=2000
	sizeKB=$(git count-objects | cut -d " " -f 3)
	if [ $sizeKB -gt $threshold ]
	then
		echo false
		return
	fi
	echo true
}

# Configure and run one-time and regular Git setup commands
setupGitOnce() {
	[[ -f $HOME/.hushdiff ]] && useDiffIndicator=false || useDiffIndicator=true
	zstyle ':vcs_info:git:*' check-for-changes $useDiffIndicator
	zstyle ':vcs_info:git:*' formats $(buildRightPrompt noAction $useDiffIndicator)
	zstyle ':vcs_info:git:*' actionformats $(buildRightPrompt action $useDiffIndicator)
}
setupGitRegular() {
	git rev-parse &> /dev/null || {RPROMPT=""; return;}
	draft='${vcs_info_msg_0_}'
	RPROMPT=$(echo "$draft $(getCommits $PWD)" | xargs echo -n) # xargs for trimming
	vcs_info
}
setupGitOnce
precmd_functions+=(setupGitRegular)
