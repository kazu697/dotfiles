return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true },
    indent = { enabled = false },
    picker = {
      focus = "list", -- 結果リストにフォーカス（normalモード）
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git", ".jj" },
        },
        files = {
          hidden = true,
        },
      },
    },
  },
  keys = {
    {
      "<leader>gd",
      function()
        -- 現在のブランチのPR番号を取得
        local pr_number = vim.fn.system("gh pr view --json number -q .number 2>/dev/null"):gsub("\n", "")
        if pr_number == "" or vim.v.shell_error ~= 0 then
          vim.notify("No PR found for current branch", vim.log.levels.WARN)
          return
        end
        -- PR番号を数値に変換して差分を表示
        Snacks.picker.gh_diff({ pr = tonumber(pr_number) })
      end,
      desc = "GitHub: Current branch PR diff",
    },
  },
  init = function()
    -- ファイル/フォルダの色設定（Gitの変更がある場合のみ色が付く）
    local function set_snacks_hl()
      vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Normal" })
      vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Comment" }) -- gitignoreはグレー
      vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { link = "Normal" })
    end
    set_snacks_hl()
    -- カラースキーム変更時にも再適用
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_snacks_hl,
    })
  end,
}
