return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "go", "lua", "typescript" }, -- Go と Lua を Treesitter 対応させる
			highlight = {
				enable = true,                               -- Tree-sitter でのハイライトを有効化
			},
		})
	end,
}
