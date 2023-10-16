#!/usr/bin/env false

# Define colors
# Standard
export colorUser=1
export colorDirectory=12
export colorSep=8
# Git
export colorAction=15
export colorRepo=6
export colorBranch=3
export colorStaged=2
export colorUnstaged=9
export colorUnknown=$colorSep
export colorUnpushed=13
export colorUnpulled=10

# Define exit code indicator
ecI=$(echo '
%(0?..%F{7})
%(1?.%F{1}.)
%(2?.%F{3}.)
%(126?.%F{5}.)
%(127?.%F{5}.)
%(128?.%F{7}.)
%(130?.%F{2}.)
%(137?.%F{4}.)
%(255?.%F{6}.)
%(0?.%#.▐%S$?%s▌%f)
' | tr '\n' ' ' | sed 's/ *//g')

# Set PS1
PS1=$'%F{$colorUser}%n%f%F{$colorSep}@%f%F{$colorMachine}%B%m%b%f %F{$colorDirectory}%{\033[3m%}%1~%{\033[0m%}%f'" $ecI "

# Set strings for unstaged and staged changes
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'

# Get function to set right prompt with VCS info
buildRightPrompt() {
	sep=→
	base=%B%F{$colorRepo}%r%f%%b%F{$colorSep}$sep%f%B%F{$colorBranch}%b%f%%b
	indicatorsString=%F{$colorUnstaged}%u%f%F{$colorStaged}%c%f
	indicatorDefault=?
	indicatorDefaultString=%F{$colorUnknown}$indicatorDefault%f
	[ $1 = "action" ] && base=$(echo %F{$colorAction}%B%a%%b%f%F{$colorSep}:%f"$base")
	[ $2 = "true" ] && base=$(echo $base$indicatorsString) || base=$(echo $base$indicatorDefaultString)
	echo $base
}

# Define function to check commits
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
	[ ${#nCommitsUnpushed} -gt 0 ] && final=$final$strUnpushed
	[ ${#nCommitsUnpulled} -gt 0 ] && final=$final$strUnpulled
	[ ${#final} -eq 0 ] && {
		echo ""
		return
	}
	echo " $final"
}
