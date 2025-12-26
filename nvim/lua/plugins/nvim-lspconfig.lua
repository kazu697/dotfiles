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
		{
			"saghen/blink.cmp",
		},
	},
	event = { "BufReadPre", "BufNewFile" },
	-- LSP設定は nvim/lua/config/lsp.lua と nvim/lsp/*.lua で管理
	-- vim.lsp.config (Neovim 0.11+) を使用
	config = function()
		require("config.lsp")
	end,
}
