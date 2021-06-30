# Set PS1
PS1='%F{1}%n%f%F{8}@%f%F{7}%B%m%b%f %F{69}%1~%f %# '

# Set right prompt VCS options
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' stagedstr '*'
zstyle ':vcs_info:git:*' unstagedstr '*'
RPROMPT='${vcs_info_msg_0_}'

# Get function to check commits
checkCommits() {
	branch=$(git branch -vv | grep ^\*)
	branchLocal=$(echo $branch | cut -d " " -f 2)
	branchRemote=$(echo $branch | cut -d " " -f 4 | sed 's/\[//' | sed 's/\://')
	echo $branchLocal #TEMP
	echo $branchRemote #TEMP
}
checkCommits

# Get function to set right prompt with VCS info
buildRightPrompt() {
	colorRepo=6
	colorSep=8
	colorBranch=214
	colorStaged=green
	colorUnstaged=red
	colorUnknown=$colorSep
	sep=→
	base=%B%F{$colorRepo}%r%f%%b%F{$colorSep}$sep%f%F{$colorBranch}%b%f
	indicatorsString=%F{$colorStaged}%c%f%F{$colorUnstaged}%u%f
	indicatorDefault=?
	indicatorDefaultString=%F{$colorUnknown}$indicatorDefault%f
	if [ $1 = "action" ];
	then
		base=$(echo %B%a%%b "$base")
	fi
	if [ $2 = "true" ];
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
	vcs_info
	git branch &> /dev/null || return
	useDiffIndicator=$(timeoutGitStatusDiff)
	zstyle ':vcs_info:git:*' check-for-changes $useDiffIndicator
	zstyle ':vcs_info:git:*' formats $(buildRightPrompt noAction $useDiffIndicator)
	zstyle ':vcs_info:git:*' actionformats $(buildRightPrompt action $useDiffIndicator)
}
setupGitRegular
precmd() {
	setupGitRegular
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
