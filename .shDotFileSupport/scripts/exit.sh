#!/usr/bin/osascript

# Quit if the last window just closed
tell application "Terminal"
	if count windows is 0 then quit
	if count windows is 1 then
		if processes of window 1 is {"login", "-zsh", "screen"} then quit
	end if
end tell

# Quit if there aren't any running processes, independent of open windows
# tell application "Terminal"
# 	set busyWndws to {}
# 	repeat with wndw in every window
# 		if (count processes of wndw) > 0 then
# 			set end of busyWndws to wndw
# 		end if
# 	end repeat
# 	if (count of busyWndws) is 0 then
# 		quit
# 	end if
# 	if (count of busyWndws) is 1 then
# 		set wndw to item 1 of busyWndws
# 		if processes of wndw is {"login", "-zsh", "screen"} then
# 			quit
# 		end if
# 	end if
# end tell
