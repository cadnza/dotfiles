#!/usr/bin/env zsh

# Run patch to speed up git completion
# (I currently don't understand how this works. I'm pending reading into the zsh completion system, but that's not a priority right now.)
# The fix comes from here:
#     https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off#9810485
__git_files () {
	_wanted files expl 'local files' _files
}

# Set PS1
PS1='%F{$colorUser}%n%f%F{$colorSep}@%f%F{$colorMachine}%B%m%b%f %F{$colorDirectory}%1~%f %# '

# Set right prompt VCS options
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'

# Get function to check commits
getCommits() {
	workingDirectory=$1
	branch=$(git -C $workingDirectory branch -vv | grep ^\* | grep -Eo '\[.+\]') # Taking a long time
	nCommitsUnpushed=$(echo $branch | grep -Eo 'ahead [[:digit:]]+' | cut -d " " -f 2) # Taking a long time
	nCommitsUnpulled=$(echo $branch | grep -Eo 'behind [[:digit:]]+' | cut -d " " -f 2) # Taking a long time
	unpushed=↑
	unpulled=↓
	strUnpushed=%F{$colorUnpushed}%B$unpushed%b$nCommitsUnpushed%f
	strUnpulled=%F{$colorUnpulled}%B$unpulled%b$nCommitsUnpulled%f
	final=""
	if [ ${#nCommitsUnpushed} -gt 0 ]
	then
		final=$final$strUnpushed
	fi
	if [ ${#nCommitsUnpulled} -gt 0 ]
	then
		final=$final$strUnpulled
	fi
	if [ ${#final} -eq 0 ]
	then
		echo ""
		return
	fi
	echo $final
}

# Get function to set right prompt with VCS info
buildRightPrompt() {
	sep=→
	base=%B%F{$colorRepo}%r%f%%b%F{$colorSep}$sep%f%F{$colorBranch}%b%f
	indicatorsString=%F{$colorUnstaged}%u%f%F{$colorStaged}%c%f
	indicatorDefault=?
	indicatorDefaultString=%F{$colorUnknown}$indicatorDefault%f
	if [ $1 = "action" ]
	then
		base=$(echo %F{$colorAction}%B%a%%b%f%F{$colorSep}:%f"$base")
	fi
	if [ $2 = "true" ]
	then
		base=$(echo $base$indicatorsString)
	else
		base=$(echo $base$indicatorDefaultString)
	fi
	echo $base
}

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
precmd() {
	setupGitRegular
}
