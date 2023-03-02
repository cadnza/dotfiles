#!/usr/bin/env false

# Set PS1
PS1='%F{$colorUser}%n%f%F{$colorSep}@%f%F{$colorMachine}%B%m%b%f %F{$colorDirectory}%1~%f %# '

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
