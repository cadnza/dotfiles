#!/usr/bin/env false

# Define colors
# Generic
export fgPurple=56
export bgPurple=189
export fgCyan=20
export bgCyan=51
export fgMint=61
export bgMint=86
export fgPink=124
export bgPink=213
export fgOrange=52
export bgOrange=208
export fgDandelion=52
export bgDandelion=214
export fgGreen=22
export bgGreen=46
export fgRed=52
export bgRed=196
export fgGray=255
export bgGray=240
# Standard
[ $isDarkMode = 1 ] && export colorTxtStandard=0 || export colorTxtStandard=#FFFFFF
export fgUser=$fgPink
export bgUser=$bgPink
export fgMachine=$fgCyan
export bgMachine=$bgCyan
export fgDirectory=$fgPurple
export bgDirectory=$bgPurple
# Git
export fgAction=15
export bgAction=0
export fgRepo=$fgPurple
export bgRepo=$bgPurple
export fgBranch=$fgDandelion
export bgBranch=$bgDandelion
export fgStaged=$fgGreen
export bgStaged=$bgGreen
export fgUnstaged=$fgRed
export bgUnstaged=$bgRed
export fgUnknown=$fgGray
export bgUnknown=$bgGray
export fgUnpushed=$fgMint
export bgUnpushed=$bgMint
export fgUnpulled=10
export bgUnpulled=10
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

# Set strings for unstaged and staged changes
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'

# Get function to set right prompt with VCS info
buildRightPrompt() {
	base="%B$(cfb $fgRepo $bgRepo 0)%r$nfb$(cfb $fgBranch $bgBranch 0)%b$nfb%%b"
	indicatorsString="%B$(cfb $fgUnstaged $bgUnstaged 0)%u$nfb$(cfb $fgStaged $bgStaged 0)%c$nfb%%b"
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
	strUnpushed="%B$(cfb $fgUnpushed $bgUnpushed 0)$unpushed$nfb%b"
	strUnpulled=
	final=""
	[ ${#nCommitsUnpushed} -gt 0 ] && final=$final$strUnpushed
	[ ${#nCommitsUnpulled} -gt 0 ] && final=$final$strUnpulled
	[ ${#final} -eq 0 ] && {
		echo ""
		return
	}
	echo $final
}
