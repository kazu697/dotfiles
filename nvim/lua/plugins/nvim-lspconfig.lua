---@type LazyPluginSpec
return {
	"neovim/nvim-lspconfig",
	-- Bufferが読み込まれるときをトリガーに遅延ロードする
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library",    words = { "vim%.uv" } },
					{ path = "snacks.nvim/lua/snacks" },
				},
			},
		},
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig");
		lspconfig.lua_ls.setup {}
	end,
}
