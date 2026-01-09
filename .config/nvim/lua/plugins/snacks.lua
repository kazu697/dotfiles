return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@type snacks.Config
	opts = {
		-- アイコン設定
		icons = {
			files = {
				enabled = true,
			},
		},
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = {
			enabled = true,
			hidden = true,
			ignored = true,
		},
		indent = { enabled = false },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = {
			enabled = true,
			-- 隠しファイルを検索結果に含める
			sources = {
				files = {
					hidden = true, -- 隠しファイルを表示
				},
				grep = {
					hidden = true, -- grepでも隠しファイルを検索
				},
				explorer = {
					hidden = true,
					ignored = true,
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		terminal = {
			enabled = true,
			-- win = {
			-- 	position = "float",
			-- 	border = "single",
			-- 	width = 0.8,
			-- 	height = 0.6,
			-- 	winblend = 30,
			-- }
		},
		scroll = {
			enabled = false,
			animate = {
				duration = { step = 10, total = 200 },
				easing = "linear",
			},
			-- faster animation when repeating scroll after delay
			animate_repeat = {
				delay = 100, -- delay in ms before using the repeat animation
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
			-- what buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
			end,
		},
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			}
		},
		styles = {
			width = 0.6,
			height = 0.6,
			border = true,
			title = " Git Blame ",
			title_pos = "center",
			ft = "git",
		},
		toggle = {
			map = vim.keymap.set,
			which_key = true,
		},
		gh = {
			enabled = true,
			--- Keymaps for GitHub buffers
			---@type table<string, snacks.gh.Keymap|false>?
			keys = {
				select  = { "<cr>", "gh_actions", desc = "Select Action" },
				edit    = { "i", "gh_edit", desc = "Edit" },
				comment = { "a", "gh_comment", desc = "Add Comment" },
				close   = { "c", "gh_close", desc = "Close" },
				reopen  = { "o", "gh_reopen", desc = "Reopen" },
			},
			---@type vim.wo|{}
			wo = {
				breakindent = true,
				wrap = true,
				showbreak = "",
				linebreak = true,
				number = false,
				relativenumber = false,
				foldexpr = "v:lua.vim.treesitter.foldexpr()",
				foldmethod = "expr",
				concealcursor = "n",
				conceallevel = 2,
				list = false,
				-- winhighlight = Snacks.util.winhl({
				--   Normal = "SnacksGhNormal",
				--   NormalFloat = "SnacksGhNormalFloat",
				--   FloatBorder = "SnacksGhBorder",
				--   FloatTitle = "SnacksGhTitle",
				--   FloatFooter = "SnacksGhFooter",
				-- }),
			},
			---@type vim.bo|{}
			bo = {},
			diff = {
				min = 4, -- minimum number of lines changed to show diff
				wrap = 80, -- wrap diff lines at this length
			},
			scratch = {
				height = 15, -- height of scratch window
			},
			icons = {
				logo = " ",
				user = " ",
				checkmark = " ",
				crossmark = " ",
				block = "■",
				file = " ",
				checks = {
					pending = " ",
					success = " ",
					failure = "",
					skipped = " ",
				},
				issue = {
					open      = " ",
					completed = " ",
					other     = " "
				},
				pr = {
					open   = " ",
					closed = " ",
					merged = " ",
					draft  = " ",
					other  = " ",
				},
				review = {
					approved          = " ",
					changes_requested = " ",
					commented         = " ",
					dismissed         = " ",
					pending           = " ",
				},
				merge_status = {
					clean    = " ",
					dirty    = " ",
					blocked  = " ",
					unstable = " "
				},
				reactions = {
					thumbs_up   = "👍",
					thumbs_down = "👎",
					eyes        = "👀",
					confused    = "😕",
					heart       = "❤️",
					hooray      = "🎉",
					laugh       = "😄",
					rocket      = "🚀",
				},
			},
		},
		{
			-- automatically configure lazygit to use the current colorscheme
			-- and integrate edit with the current neovim instance
			configure = true,
			-- extra configuration for lazygit that will be merged with the default
			-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
			-- you need to double quote it: `"\"test\""`
			config = {
				os = {
					editPreset = "nvim-remote",
					edit = "nvim --server $NVIM --remote-tab-silent {{filename}}"
				},
				gui = {
					-- set to an empty string "" to disable icons
					nerdFontsVersion = "3",
				},
			},
			-- theme_path = svim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
			-- Theme for lazygit
			theme = {
				[241]                      = { fg = "Special" },
				activeBorderColor          = { fg = "MatchParen", bold = true },
				cherryPickedCommitBgColor  = { fg = "Identifier" },
				cherryPickedCommitFgColor  = { fg = "Function" },
				defaultFgColor             = { fg = "Normal" },
				inactiveBorderColor        = { fg = "FloatBorder" },
				optionsTextColor           = { fg = "Function" },
				searchingActiveBorderColor = { fg = "MatchParen", bold = true },
				selectedLineBgColor        = { bg = "Visual" }, -- set to `default` to have no background colour
				unstagedChangesColor       = { fg = "DiagnosticError" },
			},
			win = {
				style = "lazygit",
			},
		}
	},
	keys = {
		-- Top Pickers & Explorer
		{ "<leader><space>", function() Snacks.picker.smart() end,                                         desc = "Smart Find Files" },
		{ "<leader>,",       function() Snacks.picker.buffers() end,                                       desc = "Buffers" },
		{ "<leader>/",       function() Snacks.picker.grep() end,                                          desc = "Grep" },
		{ "<leader>:",       function() Snacks.picker.command_history() end,                               desc = "Command History" },
		{ "<leader>n",       function() Snacks.picker.notifications() end,                                 desc = "Notification History" },
		{ "<leader>e",       function() Snacks.explorer() end,                                             desc = "File Explorer" },
		-- find
		{ "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,       desc = "Find Config File" },
		{ "<leader>ff",      function() Snacks.picker.files() end,                                         desc = "Find Files" },
		{ "<leader>fp",      function() Snacks.picker.projects() end,                                      desc = "Projects" },
		{ "<leader>fr",      function() Snacks.picker.recent() end,                                        desc = "Recent" },
		-- git
		{ "<leader>gb",      function() Snacks.picker.git_branches() end,                                  desc = "Git Branches" },
		{ "<leader>gl",      function() Snacks.picker.git_log() end,                                       desc = "Git Log" },
		{ "<leader>gL",      function() Snacks.picker.git_log_line() end,                                  desc = "Git Log Line" },
		{ "<leader>gs",      function() Snacks.picker.git_status() end,                                    desc = "Git Status" },
		{ "<leader>gS",      function() Snacks.picker.git_stash() end,                                     desc = "Git Stash" },
		{ "<leader>gd",      function() Snacks.picker.git_diff() end,                                      desc = "Git Diff (Hunks)" },
		{ "<leader>gf",      function() Snacks.picker.git_log_file() end,                                  desc = "Git Log File" },
		-- gh
		{ "<leader>gi",      function() Snacks.picker.gh_issue() end,                                      desc = "GitHub Issues (open)" },
		{ "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,                     desc = "GitHub Issues (all)" },
		{ "<leader>gO",      function() Snacks.picker.gh_pr() end,                                         desc = "PRs" },
		{ "<leader>gp",      function() require("plugins.snacks.gh-pr-custom").my_prs() end,               desc = "My Open PRs" },
		{ "<leader>gP",      function() require("plugins.snacks.gh-pr-custom").review_requested_prs() end, desc = "Review Requested PRs" },
		{ "<leader>gP",      function() require("plugins.snacks.gh-pr-custom").review_requested_prs() end, desc = "Review Requested PRs" },
		-- Grep
		{ "<leader>sb",      function() Snacks.picker.lines() end,                                         desc = "Buffer Lines" },
		{ "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                  desc = "Grep Open Buffers" },
		{ "<leader>sg",      function() Snacks.picker.grep() end,                                          desc = "Grep" },
		{ "<leader>sw",      function() Snacks.picker.grep_word() end,                                     desc = "Visual selection or word", mode = { "n", "x" } },
		-- search
		{ '<leader>s"',      function() Snacks.picker.registers() end,                                     desc = "Registers" },
		{ '<leader>s/',      function() Snacks.picker.search_history() end,                                desc = "Search History" },
		{ "<leader>sa",      function() Snacks.picker.autocmds() end,                                      desc = "Autocmds" },
		{ "<leader>sb",      function() Snacks.picker.lines() end,                                         desc = "Buffer Lines" },
		{ "<leader>sc",      function() Snacks.picker.command_history() end,                               desc = "Command History" },
		{ "<leader>sC",      function() Snacks.picker.commands() end,                                      desc = "Commands" },
		{ "<leader>sd",      function() Snacks.picker.diagnostics() end,                                   desc = "Diagnostics" },
		{ "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                            desc = "Buffer Diagnostics" },
		{ "<leader>sh",      function() Snacks.picker.help() end,                                          desc = "Help Pages" },
		{ "<leader>sH",      function() Snacks.picker.highlights() end,                                    desc = "Highlights" },
		{ "<leader>si",      function() Snacks.picker.icons() end,                                         desc = "Icons" },
		{ "<leader>sj",      function() Snacks.picker.jumps() end,                                         desc = "Jumps" },
		{ "<leader>sk",      function() Snacks.picker.keymaps() end,                                       desc = "Keymaps" },
		{ "<leader>sl",      function() Snacks.picker.loclist() end,                                       desc = "Location List" },
		{ "<leader>sm",      function() Snacks.picker.marks() end,                                         desc = "Marks" },
		{ "<leader>sM",      function() Snacks.picker.man() end,                                           desc = "Man Pages" },
		{ "<leader>sp",      function() Snacks.picker.lazy() end,                                          desc = "Search for Plugin Spec" },
		{ "<leader>sq",      function() Snacks.picker.qflist() end,                                        desc = "Quickfix List" },
		{ "<leader>sR",      function() Snacks.picker.resume() end,                                        desc = "Resume" },
		{ "<leader>su",      function() Snacks.picker.undo() end,                                          desc = "Undo History" },
		{ "<leader>uC",      function() Snacks.picker.colorschemes() end,                                  desc = "Colorschemes" },
		-- LSP
		-- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		-- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
		{ "gr",              function() Snacks.picker.lsp_references() end,                                nowait = true,                     desc = "References" },
		{ "gI",              function() Snacks.picker.lsp_implementations() end,                           desc = "Goto Implementation" },
		{ "gy",              function() Snacks.picker.lsp_type_definitions() end,                          desc = "Goto T[y]pe Definition" },
		{ "gai",             function() Snacks.picker.lsp_incoming_calls() end,                            desc = "C[a]lls Incoming" },
		{ "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                            desc = "C[a]lls Outgoing" },
		{ "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                   desc = "LSP Symbols" },
		{ "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                         desc = "LSP Workspace Symbols" },
		-- Other
		{ "<leader>.",       function() Snacks.scratch() end,                                              desc = "Toggle Scratch Buffer" },
		{ "<leader>S",       function() Snacks.scratch.select() end,                                       desc = "Select Scratch Buffer" },
		{ "<leader>n",       function() Snacks.notifier.show_history() end,                                desc = "Notification History" },
		{ "<leader>bd",      function() Snacks.bufdelete() end,                                            desc = "Delete Buffer" },
		{ "<leader>cR",      function() Snacks.rename.rename_file() end,                                   desc = "Rename File" },
		{ "<leader>gB",      function() Snacks.gitbrowse() end,                                            desc = "Git Browse",               mode = { "n", "v" } },
		{ "<leader>gg",      function() Snacks.lazygit() end,                                              desc = "Lazygit" },
		{ "<leader>un",      function() Snacks.notifier.hide() end,                                        desc = "Dismiss All Notifications" },
		{ "<c-/>",           function() Snacks.terminal() end,                                             desc = "Toggle Terminal" },
		{ "<c-_>",           function() Snacks.terminal() end,                                             desc = "which_key_ignore" },
		{ "]]",              function() Snacks.words.jump(vim.v.count1) end,                               desc = "Next Reference",           mode = { "n", "t" } },
		{ "[[",              function() Snacks.words.jump(-vim.v.count1) end,                              desc = "Prev Reference",           mode = { "n", "t" } },
	},
	init = function()
		-- 隠しファイル/ディレクトリの色を通常と同じにする
		vim.api.nvim_set_hl(0, "SnacksExplorerHidden", { link = "Normal" })

		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end

				-- Override print to use snacks for `:=` command
				if vim.fn.has("nvim-0.11") == 1 then
					vim._print = function(_, ...)
						dd(...)
					end
				else
					vim.print = _G.dd
				end

				-- Create some toggle mappings
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
					"<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
				Snacks.toggle.line_number():map("<leader>uN")
			end,
		})
	end,
}
