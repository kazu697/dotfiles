return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true },
    indent = { enabled = false },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git" },
        },
      },
    },
  },
  init = function()
    -- 隠しファイルの色を通常と同じにする
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Normal" })
  end,
}
