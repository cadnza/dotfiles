VERSION = "1.0.0"

local micro = import("micro")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local config = import("micro/config")
local util = import("micro/util")

function init()
	config.MakeCommand("mxc", mxc, config.OptionComplete)
	config.TryBindKey("F5","lua:mxc.mxc",false)
	config.MakeCommand("mxc", mxcx, config.OptionComplete)
	config.TryBindKey("F6","lua:mxc.mxcx",false)
end

function mxc()
	driver(false)
end

function mxcx()
	driver(true)
end

function driver(lookForMxcFile)
	-- Get current pane
	local bp = micro.CurPane()
	-- Save buffer -- Make this optional --TEMP
	bp:Save()
	micro.InfoBar():ClearInfo()
	-- Get path of current file in buffer
	local fPath = bp.Buf.AbsPath
	-- Run main script
	local mainScript = os.getenv( "HOME" ).."/.config/micro/plug/mxc/main.sh"
	local scriptString
	if lookForMxcFile then
		scriptString = mainScript.." "..fPath.." ".."1"
	else
		scriptString = mainScript.." "..fPath
	end
	local str, err = shell.RunInteractiveShell(scriptString, true, false)
	-- Show any error
	if err ~= nil then
		micro.InfoBar():Error(err)
	end
end
