# Define colors
# Standard
export color_user=1
export color_directory=12
export color_sep=8
# Git
export color_action=15
export color_repo=6
export color_branch=3
export color_staged=2
export color_unstaged=9
export color_unknown=$color_sep

# Define exit code indicator
exit_code_indicator=$(echo '
%(0?..%F{7})
%(1?.%F{1}.)
%(2?.%F{3}.)
%(126?.%F{5}.)
%(127?.%F{5}.)
%(128?.%F{7}.)
%(130?.%F{2}.)
%(137?.%F{4}.)
%(255?.%F{6}.)
%(0?.%#.▐%S$?%s▌%f%f)
' | tr '\n' ' ' | sed 's/ *//g')

# Set PS1
# shellcheck disable=SC2025,SC2154
PS1=$'%F{$color_user}%n%f%F{$color_sep}@%f%F{$color_machine}%B%m%b%f %F{$color_directory}%{\033[3m%}%1~%{\033[0m%}%f'" $exit_code_indicator "

# Set strings for unstaged and staged changes
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'

# Define function to set right prompt with VCS info
build_right_prompt() {
    sep=→
    base=%B%F"{""$color_repo""}""%r%f%%b%F""{""$color_sep""}"$sep%f%B%F"{""$color_branch""}"%b%f%%b
    [ "$1" = "action" ] && base=%F"{""$color_action""}""%B%a%%b%f%F""{""$color_sep""}"":%f""$base"
    echo "$base"
}
