#!/usr/bin/env zsh

# Load colors
autoload -U colors
colors

# Configure prompt colors
# Standard prompt
export colorUser=1
export colorDirectory=69
# Machine
export colorMacos=7
export colorLinux=2
export colorWindows=208
export colorOther=5
# Git
export colorAction=15
export colorRepo=6
export colorBranch=214
export colorStaged=2
export colorUnstaged=9
export colorUnknown=$colorDirectory
export colorUnpushed=13
export colorUnpulled=10
# Global separator
export colorSep=8

# Echo color variables if requested (for using colors with other interpreters, e.g. R)
[[ $1 = '--echo' ]] && {
	cd $(dirname $0)
	source setupOS.sh --getColorMachine 2> /dev/null
	typeset | grep '^color'
	cd $OLDPWD
}

# Set Xterm
export TERM=xterm-256color

# Configure BSD colors
export CLICOLOR=yes
export LSCOLORS=ExfxcxdxBxegedabagacad

# Configure GNU colors
export LS_COLORS='rs=0:di=1;34:ln=35:so=32:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Configure man page formatting preferences
export LESS_TERMCAP_mb=$(print -P "%F{cyan}") # Blink
export LESS_TERMCAP_md=$(print -P "%B%F{red}") # Bold
export LESS_TERMCAP_us=$(print -P "%U%F{green}") # Underline
export LESS_TERMCAP_so=$(print -P "%K{magenta}") # Standout

# Set man page formatting resets
export LESS_TERMCAP_me=$(print -P "%f%b") # End bold, blink, underline
export LESS_TERMCAP_ue=$(print -P "%f%u") # End underline
export LESS_TERMCAP_se=$(print -P "%K{black}") # End standout
