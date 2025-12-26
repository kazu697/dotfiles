vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.wrap = false;
vim.o.cursorline = true;

-- 外部でファイルが変更された場合、自動的に読み込む
vim.opt.autoread = true

-- Neovim がフォーカスを得た時やバッファに入った時に変更をチェック
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	command = "checktime",
})
vim.diagnostic.config({ severity_sort = true })

local tabWidth = 2;

vim.opt.tabstop = tabWidth;
vim.opt.softtabstop = tabWidth;
vim.opt.shiftwidth = tabWidth;

vim.o.smartindent = true;

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- splitで下に開く方法
vim.opt.splitbelow = true;
-- vsplitで右に開く方法
vim.opt.splitright = true;

vim.keymap.set("n", "P", "o<Esc>p", { noremap = true, silent = true });

--画面移動をctrl + hjkl に変更
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true });
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true });
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true });
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true });

-- 全選択をCtrl + a に変更
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true });

vim.keymap.set("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true });

-- 相対パスをクリップボードにコピー
vim.keymap.set("n", "<leader>yp", function()
	require("config.utils").copy_relative_path()
end, { noremap = true, silent = true, desc = "Yank relative path" })

--#INSERT MODE
vim.keymap.set("i", "<C-d>", "<Del>", { noremap = true, silent = true });
