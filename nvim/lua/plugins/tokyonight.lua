return {
	"folke/tokyonight.nvim",
	disable = false,
	lazy = false,
	priority = 2000,
	opts = {},
	config = function()
		-- カラースキームを適用
		vim.cmd([[colorscheme tokyonight]])
	end,
}
