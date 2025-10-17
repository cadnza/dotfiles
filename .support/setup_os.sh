# Set OS values
os_macos=1
os_linux=2
os_windows=3
os_other=4

# Determine OS
working_os=0
case "${OSTYPE:0:3}" in
dar)
    working_os=$os_macos
    ;;
lin)
    working_os=$os_linux
    ;;
bsd)
    working_os=$os_linux
    ;;
cyg)
    working_os=$os_windows
    ;;
msy)
    working_os=$os_windows
    ;;
*)
    working_os=$os_other
    ;;
esac

# Get function to show for zsh-syntax-highlighting install instructions
show_zsh_install_instructions() {
    echo "To enable syntax highlighting, run \`$1\` and start a new shell." >&2
}

# Configure settings per OS
if [ $working_os = $os_macos ]; then
    # Set machine prompt color
    export color_machine=$color_macos
    # Enable syntax highlighting
    source $(brew --prefix 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || {
        show_zsh_install_instructions "brew install zsh-syntax-highlighting"
    }
    # Check for light mode
    [ $TERM_PROGRAM = Apple_Terminal ] && {
        [ $(
            defaults read -g AppleInterfaceStyle &>/dev/null
            echo $?
        ) = 0 ] || export is_dark_mode=0
    }
# Linux
elif [ $working_os = $os_linux ]; then
    # Set machine prompt color
    export color_machine=$color_linux
    # Enable syntax highlighting
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || {
        show_zsh_install_instructions "sudo apt install zsh-syntax-highlighting"
    }
# Windows
elif [ $working_os = $os_windows ]; then
    # Set machine prompt color
    export color_machine=$color_windows
    # Enable command to enable zsh-syntax-highlighting
    source $HOME/.support/zshSyntaxHighlightingPull.sh
    # Make sure /usr/bin is first in path
    export PATH=/usr/bin:$PATH
# Other
else
    # Set machine prompt color
    export color_machine=$color_other
    # Enable command to enable zsh-syntax-highlighting
    source $HOME/.support/zshSyntaxHighlightingPull.sh
fi

# Add aliases for non-macos machines
if [ $working_os != $os_macos ]; then
    alias ls="ls --color=auto"
    alias gtimeout="timeout"
fi
