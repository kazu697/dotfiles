vim.opt.number = true;
vim.opt.relativenumber = true;
vim.diagnostic.config({severity_sort = true})

local tabWidth = 2;

vim.opt.tabstop = tabWidth;
vim.opt.softtabstop = tabWidth;
vim.opt.shiftwidth = tabWidth;

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
