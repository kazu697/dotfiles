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
    -- 隠しファイル/ignoredファイルの色を通常と同じにする
    local function set_snacks_hl()
      vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Normal" })
      vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Normal" })
    end
    set_snacks_hl()
    -- カラースキーム変更時にも再適用
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_snacks_hl,
    })
  end,
}
