VERSION = "1.0.0"

local micro = import("micro")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local config = import("micro/config")

function init()
	config.MakeCommand("mxc", _mxc, config.OptionComplete)
end

function _mxc()
	local fPath = micro.CurPane().Buf.AbsPath
	local str, err = shell.RunInteractiveShell(fPath, true, false)
	micro.InfoBar():Message(err) --TEMP
end
