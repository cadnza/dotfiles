# Count and banner tmux sessions
tmux ls &>/dev/null && {
    ct=$(tmux ls | grep -c .)
    ct_attached=$(tmux ls | grep -cEo "\(attached\)$")
    ct=$((ct - ct_attached))
    sessions_word=session
    [[ $ct = 1 ]] || sessions_word=$sessions_word"s"
    [[ $ct -ge 1 ]] &&
        printf '\033[30;41m%s detached \033[1mtmux\033[22m %s\033[0m\n' $ct $sessions_word >&2
}

# Count and banner screen sessions
dS='[[:digit:]]'
[[ $(screen -ls | head -n 1 | grep -c "^No Sockets") = 1 ]] || {
    ct=$(screen -ls | grep -Eo "^$dS$dS* Socket" | grep -Eo "^$dS$dS*")
    ct_attached=$(screen -ls | grep -cEo "\(Attached\)$")
    ct=$((ct - ct_attached))
    screens_word=screen
    [[ $ct = 1 ]] || screens_word=$screens_word"s"
    [[ $ct -ge 1 ]] &&
        printf '\033[37;44m%s detached \033[1m%s\033[22m\033[0m\n' $ct "$screens_word" >&2
}
