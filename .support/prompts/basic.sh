#!/usr/bin/env false

# Define colors
# Standard
export colorUser=1
export colorDirectory=69
export colorSep=8
# Git
export colorAction=15
export colorRepo=6
export colorBranch=214
export colorStaged=2
export colorUnstaged=9
export colorUnknown=$colorSep
export colorUnpushed=13
export colorUnpulled=10

# Set PS1
PS1='%F{$colorUser}%n%f%F{$colorSep}@%f%F{$colorMachine}%B%m%b%f %F{$colorDirectory}%1~%f %# '

# Get function to set right prompt with VCS info
buildRightPrompt() {
	sep=→
	base=%B%F{$colorRepo}%r%f%%b%F{$colorSep}$sep%f%F{$colorBranch}%b%f
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
	echo $final
}
