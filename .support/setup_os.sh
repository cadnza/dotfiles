# shellcheck disable=SC1090,SC2154

# Configure settings per OS
syntax_highlighting=
case "${OSTYPE:0:3}" in
dar)
    export color_machine=$color_macos
    syntax_highlighting=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
lin | bsd)
    export color_machine=$color_linux
    syntax_highlighting=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
cyg | msy)
    export color_machine=$color_windows
    # Make sure /usr/bin is first in path
    export PATH=/usr/bin:$PATH
    ;;
*)
    export color_machine=$color_other
    ;;
esac

# Enable syntax highlighting
[ -f "$syntax_highlighting" ] && source "$syntax_highlighting"
