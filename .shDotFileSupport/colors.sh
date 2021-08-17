#!/usr/bin/env zsh

# Load colors
autoload -U colors
colors

# Configure prompt colors
# Standard prompt
colorUser=1
colorDirectory=69
# Machine
colorMacos=7
colorLinux=green
colorWindows=208
colorOther=5
# Git
colorAction=15
colorRepo=6
colorBranch=214
colorStaged=green
colorUnstaged=red
colorUnknown=$colorDirectory
colorUnpushed=13
colorUnpulled=10
# Global separator
colorSep=8

# Set Xterm
export TERM=xterm-256color

# Configure BSD colors
export CLICOLOR=yes
export LSCOLORS=exfxcxdxbxegedabagacad

# Configure GNU colors
export LS_COLORS='rs=0:di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Configure man page formatting preferences
export LESS_TERMCAP_mb=$(print -P "%F{cyan}") # Blink
export LESS_TERMCAP_md=$(print -P "%B%F{red}") # Bold
export LESS_TERMCAP_us=$(print -P "%U%F{green}") # Underline
export LESS_TERMCAP_so=$(print -P "%K{magenta}") # Standout

# Set man page formatting resets
export LESS_TERMCAP_me=$(print -P "%f%b") # End bold, blink, underline
export LESS_TERMCAP_ue=$(print -P "%f%u") # End underline
export LESS_TERMCAP_se=$(print -P "%K{black}") # End standout
