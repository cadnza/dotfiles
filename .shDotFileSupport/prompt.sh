# Set colors
colorUser=1
colorMachine=7
colorDirectory=69
colorRepo=6
colorSep=8
colorBranch=214
colorStaged=green
colorUnstaged=red
colorUnknown=$colorDirectory
colorUnpushed=13
colorUnpulled=10

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
		base=$(echo %B%a%%b "$base")
	fi
	if [ $2 = "true" ]
	then
		base=$(echo $base$indicatorsString)
	else
		base=$(echo $base$indicatorDefaultString)
	fi
	echo $base
}

# Get function to measure timeout git status (to only show git diffs when economical)
timeoutGitStatusDiff() {
	inner() {
		delay=0.15
		gtimeout $delay zsh -fc "{
			git status > /dev/null;
			echo true;
		}"
		echo false;
	}
	enable=$(echo $(inner) | cut -d " " -f 1)
	echo $enable
}

# Configure and deploy Git regular setup command
setupGitRegular() {
	git branch &> /dev/null || return
	useDiffIndicator=$(timeoutGitStatusDiff)
	zstyle ':vcs_info:git:*' check-for-changes $useDiffIndicator
	zstyle ':vcs_info:git:*' formats $(buildRightPrompt noAction $useDiffIndicator)
	zstyle ':vcs_info:git:*' actionformats $(buildRightPrompt action $useDiffIndicator)
}
precmd() {
	setupGitRegular
	vcs_info
	draft='${vcs_info_msg_0_}'
	RPROMPT="$draft $(getCommits $PWD)" | xargs # For trimming
}

# Set right prompt with Git information manually
#buildRightPrompt() {
#	gitBranchRaw=$(git branch 2> /dev/null) || return
#	gitBranch=$(echo $gitBranchRaw | grep ^\* | cut -d " " -f 2)
#	gitRepoRaw=$(git rev-parse --show-toplevel 2> /dev/null) || return
#	gitRepo=$(basename $gitRepoRaw)
#	sep=→
#	colorRepo=6
#	colorSep=8
#	colorBranch=214
#	final=%B%F{"$colorRepo"}"$gitRepo"%f%b%F{"$colorSep"}"$sep"%f%F{"$colorBranch"}"$gitBranch"%f
#	echo $final
#	return
#}
#precmd(){
#	RPROMPT=$(buildRightPrompt)
#}
