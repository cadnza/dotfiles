# Add zsh-completions
type brew &> /dev/null && FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

# Add static and dynamc completion directories to fpath
fpath=($HOME/Repos/dotfiles/.support/completion_functions_static $fpath)
fpath=($HOME/Repos/dotfiles/.support/completion_functions_dynamic $fpath)

# Initialize completion
autoload -Uz compinit
compinit

# Enable completion menu selector
zstyle ':completion:*' menu select
bindkey '\e[Z' reverse-menu-complete # Shift tab

# Match completion colors to LS colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} $(echo "ma=38;5;0;48;5;$colorMachine;1")

# Source completions
find $HOME/.support/completion_scripts -type f | while read -r f
do
	source $f
done

# Enable AWS completions
complete -C aws_completer aws 2> /dev/null || :

# Enable Azure completions
. /opt/homebrew/Cellar/azure-cli/2.72.0/etc/bash_completion.d/az 2> /dev/null || :
