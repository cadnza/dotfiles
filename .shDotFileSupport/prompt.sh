# Set PS1
PS1='%F{1}%n%f%F{8}@%f%F{7}%B%m%b%f %F{69}%1~%f %# '

# Set right prompt VCS options
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '*'

# Set right prompt with VCS info
buildRightPrompt() {
	final=%B%F{6}%r%f%%b%F{8}→%f%F{214}%b%f%F{green}%c%f%F{red}%u%f
	if [ -n "$1" ];
	then
		final=$(echo %B%a%%b "$final")
	fi
	echo $final
}
zstyle ':vcs_info:*' formats $(buildRightPrompt)
zstyle ':vcs_info:*' actionformats $(buildRightPrompt 1)
RPROMPT='${vcs_info_msg_0_}'

# Get function to measure timeout git status (to only show git diffs when economical)
timeoutGitStatusDiff() {
	inner() {
		delay=0.13
		timeout $delay zsh -c "{
			git status > /dev/null;
			echo true;
		}"
		echo false;
	}
	enable=$(echo $(inner) | cut -d " " -f 1)
	echo $enable
}

# Configure command to run before every prompt
precmd () {
	useDiffIndicator=$(timeoutGitStatusDiff)
	zstyle ':vcs_info:*' check-for-changes $useDiffIndicator
	vcs_info
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
