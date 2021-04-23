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

# Enable syntax highlighting from Homebrew zsh-syntax-highlig>
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set prompt with version control information
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
	'[%F{6}%r%f](%F{214}%b%f)%F{green}%c%f%F{red}%u%f %a'
zstyle ':vcs_info:*' formats \
	'[%F{6}%r%f](%F{214}%b%f)%F{green}%c%f%F{red}%u%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '*'
precmd () { vcs_info }
PS1='%B%n%b@%m %F{69}%1~%f %# '
RPROMPT='${vcs_info_msg_0_}'
