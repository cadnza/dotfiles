VERSION = "1.0.0"

local micro = import("micro")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local config = import("micro/config")
local util = import("micro/util")

function init()
	config.MakeCommand("mxc", _mxc, config.OptionComplete)
	config.TryBindKey("F5","lua:mxc._mxc",false)
end

function _mxc()
	-- Get current pane
	local bp = micro.CurPane()
	-- Save buffer
	bp:Save()
	micro.InfoBar():ClearInfo()
	-- Get path of current file in buffer
	local fPath = bp.Buf.AbsPath
	-- Run file in perl
	local str, err = shell.RunInteractiveShell("perl "..fPath, true, false)
	-- Show any error
	if err ~= nil then
		micro.InfoBar():Error(err)
	end
end
