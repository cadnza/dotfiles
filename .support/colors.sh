#!/usr/bin/env false

# Load colors
autoload -U colors
colors

# Configure universal machine colors (don't reference these directly; use $colorMachine instead)
export colorMacos=7
export colorLinux=2
export colorWindows=9
export colorOther=5

# Set dark more variable (true for all platforms except Apple Terminal in macOS light mode)
export isDarkMode=1

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
