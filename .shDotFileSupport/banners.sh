#!/usr/bin/env zsh

# Count and banner tmux sessions
tmux ls &> /dev/null && {
	ct=$(tmux ls | grep -c .)
	ctAttached=$(tmux ls | grep -cEo "\(attached\)$")
	ct=$(($ct-$ctAttached))
	sessionsWord=session
	[[ $ct = 1 ]] || sessionsWord=$sessionsWord"s"
	[[ $ct -ge 1 ]] && \
		echo -e "\033[48;5;9m$ct detached \033[1mtmux\033[22m $sessionsWord\033[0m"
}

# Count and banner screen sessions
dS=[[:digit:]]
[[ $(screen -ls | head -n 1 | grep -c "^No Sockets") = 1 ]] || {
	ct=$(screen -ls | grep -Eo "^$dS$dS* Socket" | grep -Eo "^$dS$dS*")
	ctAttached=$(screen -ls | grep -cEo "\(Attached\)$")
	ct=$(($ct-$ctAttached))
	screensWord="\033[1mscreen\033[22m"
	[[ $ct = 1 ]] || screensWord=$screensWord"s"
	echo -e "\033[48;5;4m$ct detached $screensWord\033[0m"
}
