#!/usr/bin/env zsh

# Count and banner tmux sessions
tmux ls &> /dev/null && {
	ct=$(tmux ls | grep -c .)
	[[ $ct = 1 ]] && sessionsWord=session || sessionsWord=sessions
	ctAttached=$(tmux ls | grep -cEo "\(attached\)$")
	ct=$(($ct-$ctAttached))
	[[ $ct -ge 1 ]] && \
		echo -e "\033[48;5;9m$ct unattached \033[1mtmux\033[22m $sessionsWord open\033[0m"
}

# Count and banner screen sessions
dS=[[:digit:]]
[[ $(screen -ls | head -n 1 | grep -c "^No Sockets") = 1 ]] || {
	ct=$(screen -ls | grep -Eo "^$dS$dS* Socket" | grep -Eo "^$dS$dS*")
	screensWord="\033[1mscreen\033[22m"
	[[ $ct = 1 ]]|| screensWord=$screensWord"s"
	echo -e "\033[48;5;4m$ct $screensWord open\033[0m"
}
