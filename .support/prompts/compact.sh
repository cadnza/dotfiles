#!/usr/bin/env false

# Define colors
# Standard
[ $isDarkMode = 1 ] && export colorTxtStandard=0 || export colorTxtStandard=#FFFFFF
export fgUser=124
export bgUser=213
export fgMachine=20
export bgMachine=51
export fgDirectory=56
export bgDirectory=189
# Git
export colorAction=15
export colorRepo=6
export colorBranch=214
export colorStaged=2
export colorUnstaged=9
export colorUnknown=$colorSep
export colorUnpushed=13
export colorUnpulled=10
# Misc
export colorSep=8

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

# Define function to color foreground and background and constant to clear it
cfb() {
	case $3 in
		0)
			colorFg=$1
			colorBg=$2
			;;
		1)
			colorFg=15
			colorBg=196
			;;
		2)
			colorFg=0
			colorBg=11
			;;
		126)
			colorFg=0
			colorBg=196
			;;
		127)
			colorFg=15
			colorBg=13
			;;
		128)
			colorFg=0
			colorBg=208
			;;
		130)
			colorFg=0
			colorBg=10
			;;
		137)
			colorFg=0
			colorBg=14
			;;
		255)
			colorFg=15
			colorBg=226
			;;
		*)
			colorFg=15
			colorBg=8
			;;
	esac
	echo "%{$(print -P "%F{$colorFg}%K{$colorBg}")%}"
}
nfb="%{$(print -P "%k%f")%}"


# Build PS1 logic
buildPS1() {
	eC=$?
	PS1="%B$(cfb $fgUser $bgUser $eC)$(abp %n)$nfb$(cfb $fgMachine $bgMachine $eC)$(abp %m)$nfb$(cfb $fgDirectory $bgDirectory $eC)$(trn %1~)$nfb%(!. %F{1}#%f.)%b "
}
precmd_functions+=(buildPS1)

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
