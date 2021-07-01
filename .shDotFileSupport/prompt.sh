# Set colors
colorUser=1
colorMachine=7
colorDirectory=69
colorAction=15
colorRepo=6
colorSep=8
colorBranch=214
colorStaged=green
colorUnstaged=red
colorUnknown=$colorDirectory
colorUnpushed=13
colorUnpulled=10

# Detect OS
osMacos="darwin"
osLinux="
linux
bsd
"
osWindows="
cygwin
msys
"
osSolaris="solaris"
osHaiku="haiku"
if [[ 1 = 0 ]]; then # Dead line to avoid preferential treatment in if block
elif [[ $(echo $osMacos | grep -c -i $OSTYPE) -gt 0 ]]
then
elif [[ $(echo $osLinux | grep -c -i $OSTYPE) -gt 0 ]]
then
elif [[ $(echo $osWindows | grep -c -i $OSTYPE) -gt 0 ]]
then
elif [[ $(echo $osSolaris | grep -c -i $OSTYPE) -gt 0 ]]
then
elif [[ $(echo $osHaiku | grep -c -i $OSTYPE) -gt 0 ]]
then
fi

# Run patch to speed up git completion
# (I currently don't understand how this works. I'm pending reading into the zsh completion system, but that's not a priority right now.)
# The fix comes from here:
#     https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off#9810485
#__git_files () {
#	_wanted files expl 'local files' _files
#}

# Set PS1
PS1='%F{$colorUser}%n%f%F{$colorSep}@%f%F{$colorMachine}%B%m%b%f %F{$colorDirectory}%1~%f %# '

# Set right prompt VCS options
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' stagedstr '*'
zstyle ':vcs_info:git:*' unstagedstr '*'

# Get function to check commits
getCommits() {
	workingDirectory=$1
	branch=$(git -C $workingDirectory branch -vv 2> /dev/null || return | grep ^\* | grep -Eo '\[.+\]')
	nCommitsUnpushed=$(echo $branch | grep -Eo 'ahead [[:digit:]]+' | cut -d " " -f 2)
	nCommitsUnpulled=$(echo $branch | grep -Eo 'behind [[:digit:]]+' | cut -d " " -f 2)
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
	indicatorsString=%F{$colorStaged}%c%f%F{$colorUnstaged}%u%f
	indicatorDefault=?
	indicatorDefaultString=%F{$colorUnknown}%B$indicatorDefault%%b%f
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

# Configure and deploy Git regular setup command
setupGitRegular() {
	git rev-parse &> /dev/null || {RPROMPT=""; return;}
	useDiffIndicator=$(decideBySize)
	zstyle ':vcs_info:git:*' check-for-changes $useDiffIndicator
	zstyle ':vcs_info:git:*' formats $(buildRightPrompt noAction $useDiffIndicator)
	zstyle ':vcs_info:git:*' actionformats $(buildRightPrompt action $useDiffIndicator)
	vcs_info
	draft='${vcs_info_msg_0_}'
	RPROMPT=$(echo "$draft $(getCommits $PWD)" | xargs echo -n) # xargs for trimming
}
precmd() {
	setupGitRegular
}
