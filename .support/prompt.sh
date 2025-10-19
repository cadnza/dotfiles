# shellcheck disable=SC1090

# Run patch to speed up git completion
# (I currently don't understand how this works. I'm pending reading into the zsh completion system, but that's not a priority right now.)
# The fix comes from here:
#     https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off#9810485
__git_files() {
    _wanted files expl 'local files' _files
}

# Source chosen prompt, defaulting to basic
prompt_file="$HOME/.prompt"
prompts_dir="$HOME/.support/prompts"
basic_prompt="$prompts_dir/basic.sh"
if [ -f "$prompt_file" ]; then
    theme_name=$(cat "$prompt_file" | head -n 1)
    theme_file="$prompts_dir/$theme_name.sh"
    if [ -f "$theme_file" ]; then
        source "$theme_file"
    else
        source "$basic_prompt"
    fi
else
    source "$basic_prompt"
fi

# Set right prompt VCS options
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

# Set git options
zstyle ':vcs_info:git:*' formats "$(build_right_prompt no_action)"
zstyle ':vcs_info:git:*' actionformats "$(build_right_prompt action)"

# Register right prompt
precmd() {
    vcs_info
}
# shellcheck disable=SC2016
export RPROMPT='${vcs_info_msg_0_}'
