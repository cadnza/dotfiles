#!/usr/bin/env false

# include this from .bashrc, .zshrc or
# another shell startup file with:
#   source $HOME/.shellfishrc

# this part does nothing outside ShellFish
if [[ "$LC_TERMINAL" = "ShellFish" ]]; then
  ios_printURIComponent() {
    awk 'BEGIN {while (y++ < 125) z[sprintf("%c", y)] = y
    while (y = substr(ARGV[1], ++j, 1))
    q = y ~ /[a-zA-Z0-9]/ ? q y : q sprintf("%%%02X", z[y])
    printf("%s", q)}' "$1"
  }

  ios_printBase64Component() {
    echo -n "$1" | base64
  }

  which printf > /dev/null
  ios_hasPrintf=$?
  ios_printf() {
    if [ $ios_hasPrintf ]; then
      printf "$1"
    else
      awk "BEGIN {printf \"$1\"}"
    fi
  }

  ios_sequence() {
    if [[ -n "$TMUX" ]]; then
     OUTPUT=$(
      ios_printf '\033Ptmux;\033\033]'
      echo -n "$1" | tr -d '[:space:]'
      ios_printf '\a\033\\' )
    else
     OUTPUT=$(
      ios_printf '\033]'
      echo -n "$1" | tr -d '[:space:]'
      ios_printf '\a' )
    fi
    if [ -t 1 ] ; then
      echo -n $OUTPUT
    elif [[ -n "$SSH_TTY" ]]; then
      echo -n $OUTPUT > $SSH_TTY
    else
      echo >&2 'Standard output is not tty and there is no $SSH_TTY'
    fi
  }

  ios_sequence_spaced() {
    if [[ -n "$TMUX" ]]; then
     OUTPUT=$(
      ios_printf '\033Ptmux;\033\033]'
      echo -n "$1"
      ios_printf '\a\033\\' )
    else
     OUTPUT=$(
      ios_printf '\033]'
      echo -n "$1"
      ios_printf '\a' )
    fi
    if [ -t 1 ] ; then
      echo -n $OUTPUT
    elif [[ -n "$SSH_TTY" ]]; then
      echo -n $OUTPUT > $SSH_TTY
    else
      echo >&2 'Standard output is not tty and there is no $SSH_TTY'
    fi
  }

  # prepare fifo for communicating result back to shell
  ios_prepareResult() {
    FIFO=$(mktemp)
    rm -f $FIFO
    mkfifo $FIFO
    echo $FIFO
  }

  # wait for terminal to complete action
  ios_handleResult() {
    FIFO=$1
    if [ -n "$FIFO" ]; then
      read <$FIFO -s
      rm -f $FIFO

      if [[ $REPLY = error* ]]; then
        echo "${REPLY#error=}" | base64 >&2 -d
        return 1
      fi

      if [[ $REPLY = result* ]]; then
        echo "${REPLY#result=}" | base64 -d
      fi
    fi
  }

  sharesheet() {
      if [[ $# -eq 0 ]]; then
        if tty -s; then
          cat <<EOF
Usage: sharesheet [FILE]...

Present share sheet for files and directories. Alternatively you can pipe in text and call it without arguments.

If arguments exist inside the Files app changes made are written back to the server.
EOF
        return 0
      fi
    fi

    FIFO=$(ios_prepareResult)
    OUTPUT=$(
      awk 'BEGIN {printf "6;sharesheet://?ver=2&respond="}'
      ios_printBase64Component "$FIFO"
      awk 'BEGIN {printf "&pwd="}'
      ios_printBase64Component "$PWD"
      awk 'BEGIN {printf "&home="}'
      ios_printBase64Component "$HOME"
      for var in "$@"
      do
        awk 'BEGIN {printf "&path="}'
        ios_printBase64Component "$var"
      done
      if [[ $# -eq 0 ]]; then
        text=$(cat -)
        awk 'BEGIN {printf "&text="}'
        ios_printBase64Component "$text"
      fi
     )
    ios_sequence "$OUTPUT"
    ios_handleResult "$FIFO"
  }

  quicklook() {
    if [[ $# -eq 0 ]]; then
      if tty -s; then
            cat <<EOF
Usage: quicklook [FILE]...

Show QuickLook preview for files and directories. Alternatively you can pipe in text and call it without arguments.
EOF
        return 0
      fi
    fi

    FIFO=$(ios_prepareResult)
    OUTPUT=$(
      awk 'BEGIN {printf "6;quicklook://?ver=2&respond="}'
      ios_printBase64Component "$FIFO"
      awk 'BEGIN {printf "&pwd="}'
      ios_printBase64Component "$PWD"
      awk 'BEGIN {printf "&home="}'
      ios_printBase64Component "$HOME"
      for var in "$@"
      do
        awk 'BEGIN {printf "&path="}'
        ios_printBase64Component "$var"
      done
      if [[ $# -eq 0 ]]; then
        text=$(cat -)
        awk 'BEGIN {printf "&text="}'
        ios_printBase64Component "$text"
      fi
    )
    ios_sequence "$OUTPUT"
    ios_handleResult "$FIFO"
  }

  textastic() {
    if [[ $# -eq 0 ]]; then
      cat <<EOF
Usage: textastic <text-file>

Open in Textastic 9.5 or later.
File must be in directory represented in the Files app to allow writing back edits.
EOF
    else
      if [ ! -e "$1" ]; then
        touch "$1"
      fi
      OUTPUT=$(
        awk 'BEGIN {printf "6;textastic://?ver=2&pwd="}'
        ios_printBase64Component "$PWD"
        awk 'BEGIN {printf "&home="}'
        ios_printBase64Component "$HOME"
        awk 'BEGIN {printf "&path="}'
        ios_printBase64Component "$1"
      )
      ios_sequence "$OUTPUT"
    fi
  }

  openUrl() {
    if [[ $# -eq 0 ]]; then
      cat <<EOF
Usage: openUrl <url>

Open URL on iOS.
EOF
    else
      FIFO=$(ios_prepareResult)
      OUTPUT=$(
        awk 'BEGIN {printf "6;open://?ver=2&respond="}'
        ios_printBase64Component "$FIFO"
        awk 'BEGIN {printf "&url="}'
        ios_printBase64Component "$1"
      )
      ios_sequence "$OUTPUT"
      ios_handleResult "$FIFO"
    fi
  }

  runShortcut() {
    local baseUrl="shortcuts://run-shortcut"
    if [[ $1 == "--x-callback" ]]; then
        local baseUrl="shortcuts://x-callback-url/run-shortcut"
        shift
    fi

    if [[ $# -eq 0 ]]; then
      cat <<EOF
Usage: runShortcut [--x-callback] <shortcut-name> [input-for-shortcut]

Run in Shortcuts app bringing back results if --x-callback is included.
EOF
    else
      local name=$(ios_printURIComponent "$1")
      shift
      if [[ $* == "-" ]]; then
        local text=$(cat -)
        local input=$(ios_printURIComponent "$text")
      else
        local input=$(ios_printURIComponent "$*")
      fi
      openUrl "$baseUrl?name=$name&input=$input"
    fi
  }

  # copy standard input or arguments to iOS clipboard
  pbcopy() {
    OUTPUT=$(
      awk 'BEGIN {printf "52;c;"} '
      if [ $# -eq 0 ]; then
        base64 | tr -d '\n'
      else
        echo -n "$@" | base64 | tr -d '\n'
      fi
    )
    ios_sequence "$OUTPUT"
  }

  # paste from iOS device clipboard to standard output
  pbpaste() {
    FIFO=$(ios_prepareResult)
    OUTPUT=$(
      awk 'BEGIN {printf "6;pbpaste://?ver=2&respond="}'
      ios_printBase64Component "$FIFO"
    )
    ios_sequence "$OUTPUT"
    ios_handleResult "$FIFO"
  }

  # Secure ShellFish supports 24-bit colors
  export COLORTERM=truecolor

  if [[ -z "$INSIDE_EMACS" && $- = *i* ]]; then
    # tmux mouse mode enables scrolling with
    # swipe and mouse wheel
    if [[ -n "$TMUX" ]]; then
      tmux set -g mouse on
    fi

    # send the current directory using OSC 7 when showing prompt to
    # make filename detection work better for interactive shell
    update_terminal_cwd() {
      ios_sequence $(
        awk "BEGIN {printf \"7;%s\", \"file://$HOSTNAME\"}"
        ios_printURIComponent "$PWD"
      )
    }
    if [ -n "$ZSH_VERSION" ]; then
      precmd() { update_terminal_cwd; }
    elif [[ $PROMPT_COMMAND != *"update_terminal_cwd"* ]]; then
      PROMPT_COMMAND="update_terminal_cwd${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
    fi
  fi
fi


# Updates Terminal Data widget in Secure ShellFish
#
# This command sends encrypted data through push notifications such
# that it doesn't need to run from a Secure ShellFish terminal.
widget() {
  if [[ $# -eq 0 ]]; then
    cat <<EOF
Usage: widget <data> ...

Update widget on device from which this function was installed with a
number of content parameters that can be string, progress, icon or colors.

Each argument type is derived from input.

Progress has the form: 50% or 110/220

Icon must match valid SF Symbol name such as globe or terminal.fill

Colors must be hex colours such as #000 #ff00ff where the color is used
for later content and 'foreground' switches back to default colour

String is the fallback type if nothing else matches, but content type can be forced
for next parameter with --progress, --icon, --color or --text with something like:
  widget --text "50/100"

EOF
    return 0
  fi

  local key=c2b45985ca705cdfb3054fb25ae6d961506c38762dd5632d38f5c5a00afcc869
  local user=ofwbx9Hf0r6TSywXbgRYpH8h1VZD5vDy07z8X19S
  local iv=ab5bbeb426015da7eedcee8bee3dffb7

  local plain=$(
  echo Secure ShellFish Widget 1.0
  for var in "$@"
  do
      echo "$var"
  done)
  local base64=$(echo "$plain" | openssl enc -aes-256-cbc -base64 -K $key -iv $iv)
  curl -X POST -H "Content-Type: text/plain" --data "$base64" "https://secureshellfish.app/push/?user=$user"
}


# Shows notification on your device with Secure ShellFish installed.
#
# This command sends encrypted data through push notifications such
# that it doesn't need to run from a Secure ShellFish terminal.
notify() {
  if [[ $# -eq 0 ]]; then
    cat <<EOF
Usage: notify [title] <body> ...

EOF
    return 0
  fi

  local key=c2b45985ca705cdfb3054fb25ae6d961506c38762dd5632d38f5c5a00afcc869
  local user=ofwbx9Hf0r6TSywXbgRYpH8h1VZD5vDy07z8X19S
  local iv=ab5bbeb426015da7eedcee8bee3dffb7

  local plain=$(
  echo Secure ShellFish Notify 1.0
  for var in "$@"
  do
      echo "$var"
  done)
  local base64=$(echo "$plain" | openssl enc -aes-256-cbc -base64 -K $key -iv $iv)
  curl -X POST -H "Content-Type: text/plain" --data "$base64" "https://secureshellfish.app/push/?user=$user"
}
