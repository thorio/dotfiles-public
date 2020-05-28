local path = require('path')
local w = require('tables').wrap
local parser = clink.arg.new_parser

local NVM_ROOT

local function get_nvm_root()
	if NVM_ROOT then return NVM_ROOT end

	NVM_ROOT = os.getenv("APPDATA").."/nvm" or ""

	return NVM_ROOT
end

local installed = function ()
	return w(clink.find_dirs(get_nvm_root().."/*"))
	:filter(path.is_real_dir)
	:map(function (dir)
		return dir:match("v(.*)")
	end)
end

local archs = parser({"64", "32"})

local nvm_parser = parser({
	"arch"..archs,
	"install"..parser({"latest"}, archs),
	"list"..parser({installed, "available"}),
	"ls"..parser({installed, "available"}),
	"on", "off",
	"proxy"..parser({"none"}),
	"uninstall"..parser({installed}),
	"use"..parser({installed}, archs),
	"root",
	"version", "v"
}, "-h", "--help", "-v", "--version")

clink.arg.register_parser("nvm", nvm_parser)
