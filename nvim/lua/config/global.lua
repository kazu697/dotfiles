_G.is_macos = function()
	return vim.uv.os_uname().sysname == "Darwin"
end
