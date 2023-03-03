#!/usr/bin/env false

# Define colors
# Standard
[ $isDarkMode = 1 ] && export colorTxtStandard=0 || export colorTxtStandard=#FFFFFF
export colorUser=13
export colorMachine=51
export colorDirectory=63
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

# Define abbreviation functions
abp() {
	print -P $1 | perl -pe 's/((?<=[A-Z])[A-Z]|(?<=[A-Za-z])[a-z]|(?<=[0-9])[0-9]|[^A-Za-z0-9~])//g'
}
trn() {
	nChars=3
	expanded=$(print -P $1)
	string=$(echo $expanded | sed 's/[^A-Za-z0-9~]/ /g')
	elements=(${(s/ /)string})
	final=""
	for element in "${elements[@]}"
	do
		final=$final$(echo ${element:0:$nChars})
	done
	echo $final
}

# Build PS1 logic
buildPS1() {
	PS1="%B%F{$colorUser}$(abp %n)%f%F{$colorMachine}$(abp %m)%f%F{$colorDirectory}$(trn %1~)%f%(!. %F{1}#%f.)%b "
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
