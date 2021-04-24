# Set zsh-newuser-install settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt nomatch
bindkey -e

# Set compinstall settings
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

# Enable syntax highlighting from Homebrew zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set PS1
PS1='%F{1}%n%f%F{8}@%f%F{7}%B%m%b%f %F{69}%1~%f %# '

# Set right prompt with version control information
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats \
'%B%F{6}%r%f%%b%F{8}→%f%F{214}%b%f%F{green}%c%f%F{red}%u%f'
zstyle ':vcs_info:*' actionformats \
	'%B%a%%b %B%F{6}%r%f%%b%F{8}→%f%F{214}%b%f%F{green}%c%f%F{red}%u%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '*'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# Configure LS colors
export TERM=xterm-256color
export CLICOLOR=yes
#export LSCOLORS=exfxcxdxbxegedabagacad # Commented for now; no need to change the default

# Configure man page color
export LESS_TERMINFO_mb=$(print -P "%F{cyan}")		# Blink
export LESS_TERMINFO_md=$(print -P "%B%F{red}")		# Bold
export LESS_TERMINFO_me=$(print -P "%f%b")				# End bold, blink, underline
export LESS_TERMINFO_so=$(print -P "%K{magenta}")	# Standout
export LESS_TERMINFO_se=$(print -P "%K{black}")		# End standout
export LESS_TERMINFO_us=$(print -P "%U%F{green}") # Underline
export LESS_TERMINFO_ue=$(print -P "%f%u")				# End underline
