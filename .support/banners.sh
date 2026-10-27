# Count and banner tmux sessions
command -v tmux >/dev/null && tmux_out=$(tmux ls 2>/dev/null) && {
    ct=$(grep -c . <<<"$tmux_out")
    ct_attached=$(grep -cEo "\(attached\)$" <<<"$tmux_out")
    ct=$((ct - ct_attached))
    sessions_word=session
    [[ $ct = 1 ]] || sessions_word=$sessions_word"s"
    [[ $ct -ge 1 ]] &&
        printf '\033[30;41m%s detached \033[1mtmux\033[22m %s\033[0m\n' $ct $sessions_word >&2
}

# Count and banner screen sessions
dS='[[:digit:]]'
if command -v screen >/dev/null; then
    screen_out=$(screen -ls 2>/dev/null)
    [[ $(head -n 1 <<<"$screen_out" | grep -c "^No Sockets") = 1 ]] || {
        ct=$(grep -Eo "^$dS$dS* Socket" <<<"$screen_out" | grep -Eo "^$dS$dS*")
        ct_attached=$(grep -cEo "\(Attached\)$" <<<"$screen_out")
        ct=$((ct - ct_attached))
        screens_word=screen
        [[ $ct = 1 ]] || screens_word=$screens_word"s"
        [[ $ct -ge 1 ]] &&
            printf '\033[37;44m%s detached \033[1m%s\033[22m\033[0m\n' $ct "$screens_word" >&2
    }
fi
