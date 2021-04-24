# Configure LS colors
export TERM=xterm-256color
export CLICOLOR=yes
#export LSCOLORS=exfxcxdxbxegedabagacad # Commented for now; no need to change the default

# Configure man page formatting preferences
export LESS_TERMCAP_mb=$(print -P "%F{cyan}") # Blink
export LESS_TERMCAP_md=$(print -P "%B%F{red}") # Bold
export LESS_TERMCAP_us=$(print -P "%U%F{green}") # Underline
export LESS_TERMCAP_so=$(print -P "%K{magenta}") # Standout

# Set man page formatting resets
export LESS_TERMCAP_me=$(print -P "%f%b") # End bold, blink, underline
export LESS_TERMCAP_ue=$(print -P "%f%u") # End underline
export LESS_TERMCAP_se=$(print -P "%K{black}") # End standout
