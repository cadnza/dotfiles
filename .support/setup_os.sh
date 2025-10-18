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

# Configure settings per OS
if [ $working_os = $os_macos ]; then
    # Set machine prompt color
    export color_machine=$color_macos
    # Enable syntax highlighting
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || :
# Linux
elif [ $working_os = $os_linux ]; then
    # Set machine prompt color
    export color_machine=$color_linux
    # Enable syntax highlighting
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || :
# Windows
elif [ $working_os = $os_windows ]; then
    # Set machine prompt color
    export color_machine=$color_windows
    # Make sure /usr/bin is first in path
    export PATH=/usr/bin:$PATH
# Other
else
    # Set machine prompt color
    export color_machine=$color_other
fi

# Add aliases for non-macos machines
if [ $working_os != $os_macos ]; then
    alias ls="ls --color=auto"
    alias gtimeout="timeout"
fi
