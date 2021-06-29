# Set PS1
PS1='%F{1}%n%f%F{8}@%f%F{7}%B%m%b%f %F{69}%1~%f %# '

# Set right prompt VCS options
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes false # Set to true to show diff status markers
zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '*'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# Set right prompt with VCS info
zstyle ':vcs_info:*' formats \
	'%B%F{6}%r%f%%b%F{8}→%f%F{214}%b%f%F{green}%c%f%F{red}%u%f'
zstyle ':vcs_info:*' actionformats \
	'%B%a%%b %B%F{6}%r%f%%b%F{8}→%f%F{214}%b%f%F{green}%c%f%F{red}%u%f'

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
