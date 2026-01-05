return {
	'maxmx03/solarized.nvim',
	lazy = false,
	priority = 1000,
	---@type solarized.config
	opts = {
		transparent = {
			enabled = true,  -- Master switch to enable transparency
			pmenu = true,    -- Popup menu (e.g., autocomplete suggestions)
			normal = true,   -- Main editor window background
			normalfloat = true, -- Floating windows
			neotree = true,  -- Neo-tree file explorer
			nvimtree = true, -- Nvim-tree file explorer
			whichkey = true, -- Which-key popup
			telescope = true, -- Telescope fuzzy finder
			lazy = true,     -- Lazy plugin manager UI
			mason = true,    -- Mason manage external tooling		enabled = true,
		},
		variant = 'summer',
		on_highlights = function(colors)
			return {
				Normal = { fg = colors.base01 }, -- 通常テキストを濃い色に
				Identifier = { fg = colors.yellow }, -- 変数名を目立たせる
				Function = { fg = colors.blue }, -- 関数名を濃く
				Statement = { fg = colors.red }, -- キーワードを濃く
			}
		end,
	},
	config = function(_, opts)
		vim.o.termguicolors = true
		vim.o.background = 'dark'
		require('solarized').setup(opts)
		vim.cmd.colorscheme 'solarized'
	end,
}
