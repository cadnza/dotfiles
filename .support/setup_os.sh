# Group OSs
os_macos="darwin"
os_linux="linux bsd"
os_windows="cygwin msys"

# Define function for OS matching
try_os_match() {
    ptrn="("$(echo $1 | sed 's/ /\|/g')")"
    if [ $(echo $OSTYPE | LC_ALL=en_US.utf8 grep -Eci "$ptrn") -gt 0 ]; then
        echo $1
    else
        echo ""
    fi
}

# Record OS string for fast checking
working_os_filename=.dotfilesOS
working_os_file=$HOME/$working_os_filename
working_os=$(cat $working_os_file) 2>/dev/null || {
    working_os="$(try_os_match $os_macos)$(try_os_match $os_linux)$(try_os_match $os_windows)"
    echo $working_os >$working_os_file
}

# Get function to show for zsh-syntax-highlighting install instructions
show_zsh_install_instructions() {
    cmd=$1
    echo "To enable syntax highlighting, run \`$1\` and start a new shell."
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
