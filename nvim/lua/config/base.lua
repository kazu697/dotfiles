vim.opt.number = true;
vim.opt.relativenumber = true;
vim.diagnostic.config({severity_sort = true})

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
