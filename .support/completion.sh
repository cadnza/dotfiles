# Add zsh-completions
type brew &> /dev/null && FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

# Generate completions for tools that can emit their own, refreshing them when
# the tool is newer than its generated file (the directory is gitignored)
d_completions_dynamic=$HOME/.support/completion_functions_dynamic
mkdir -p "$d_completions_dynamic"
typeset -A completion_generators=(
    docker "docker completion zsh"
    op "op completion zsh"
    rustup "rustup completions zsh"
)
for tool generator in ${(kv)completion_generators}; do
    tool_path=$(command -v "$tool") || continue
    f_generated=$d_completions_dynamic/_$tool
    [[ $f_generated -nt $tool_path ]] && continue
    ${=generator} > "$f_generated.tmp" 2> /dev/null &&
        mv "$f_generated.tmp" "$f_generated" ||
        rm -f "$f_generated.tmp"
done

# Add generated completion directory to fpath
fpath=($d_completions_dynamic $fpath)

# Initialize completion
autoload -Uz compinit
compinit

# Enable completion menu selector
zstyle ':completion:*' menu select
bindkey '\e[Z' reverse-menu-complete # Shift tab

# Match completion colors to LS colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} $(echo "ma=38;5;0;48;5;$color_machine;1")

# Source completions
for f in $HOME/.support/completion_scripts/*.sh
do
    source "$f"
done

# Enable AWS completions
complete -C aws_completer aws 2> /dev/null || :
