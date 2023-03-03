#!/usr/bin/env false

# Define colors
# Standard
export fgStandard=0 #TEMP
export bkUser=13
export bkMachine=208
export bkDirectory=69
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

# Define abbreviation function
abp() {
	print -P $1 | perl -pe 's/((?<=[A-Z])[A-Z]|(?<=[A-Za-z])[a-z]|(?<=[0-9])[0-9]|[^A-Za-z0-9~])//g'
}

# Build PS1 logic
buildPS1() {
	PS1="%K{$bkUser}$(abp %n)%k%B%K{$bkMachine}$(abp %m)%k%b%K{$bkDirectory}$(abp %1~)%k%(!. %B%F{1}#%f%b.) "
}
precmd_functions+=(buildPS1)

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
