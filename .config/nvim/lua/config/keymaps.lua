-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy git root relative path to clipboard
vim.keymap.set("n", "<leader>yr", function()
  -- Get absolute path of current buffer
  local filepath = vim.fn.expand("%:p")

  -- Check if buffer has a filename
  if filepath == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.WARN)
    return
  end

  -- Get git root using git rev-parse
  local gitroot = vim.fn.system("git -C " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " rev-parse --show-toplevel 2>/dev/null")
  gitroot = gitroot:gsub("\n", "") -- Remove trailing newline

  -- Check if git command succeeded
  if vim.v.shell_error ~= 0 or gitroot == "" then
    vim.notify("Not in a git repository", vim.log.levels.WARN)
    return
  end

  -- Calculate relative path
  local relative = vim.fn.fnamemodify(filepath, ":s?" .. gitroot .. "/??")

  -- Copy to system clipboard (+ register)
  vim.fn.setreg("+", relative)

  -- Notify user with success message
  vim.notify("Copied (git relative): " .. relative)
end, { desc = "Copy git root relative path" })
