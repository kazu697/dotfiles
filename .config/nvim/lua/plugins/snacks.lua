-- GitHub PR差分のキャッシュ（セッション単位）
local gh_diff_cache = {
  pr_numbers = {}, -- branch_name -> pr_number
  picker_data = {}, -- pr_number -> { items, last_opened }
}

-- 現在のブランチ名を取得
local function get_current_branch()
  return vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
end

-- PR番号を取得（キャッシュあり）
local function get_pr_number()
  local branch = get_current_branch()
  if branch == "" then
    return nil
  end

  -- キャッシュにあればそれを返す
  if gh_diff_cache.pr_numbers[branch] then
    return gh_diff_cache.pr_numbers[branch]
  end

  -- キャッシュになければ取得してキャッシュに保存
  local pr_number = vim.fn.system("gh pr view --json number -q .number 2>/dev/null"):gsub("\n", "")
  if pr_number == "" or vim.v.shell_error ~= 0 then
    return nil
  end

  local pr_num = tonumber(pr_number)
  gh_diff_cache.pr_numbers[branch] = pr_num
  return pr_num
end

-- キャッシュをクリア
local function clear_gh_diff_cache()
  gh_diff_cache.pr_numbers = {}
  gh_diff_cache.picker_data = {}
  vim.notify("GitHub diff cache cleared", vim.log.levels.INFO)
end

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
          cwd = vim.fn.getcwd(), -- 現在のディレクトリのみ検索
        },
        grep = {
          cwd = vim.fn.getcwd(), -- 現在のディレクトリのみ検索
        },
        recent = {
          filter = { cwd = true }, -- 現在のディレクトリのファイルのみ表示
        },
      },
    },
  },
  keys = {
    {
      "<leader>gd",
      function()
        local pr_number = get_pr_number()
        if not pr_number then
          vim.notify("No PR found for current branch", vim.log.levels.WARN)
          return
        end

        local cached = gh_diff_cache.picker_data[pr_number]
        if cached and cached.items and #cached.items > 0 then
          -- キャッシュがあれば、finderを上書きしてキャッシュデータを使用
          Snacks.picker({
            title = "  PR Diff (cached)",
            items = cached.items,
            format = "git_status",
            preview = "gh_preview_diff",
            confirm = function(picker, item)
              if item and item.file then
                picker:close()
                vim.cmd("edit " .. item.file)
              end
            end,
          })
        else
          -- 初回はAPIを呼び出し、結果をキャッシュ
          Snacks.picker.gh_diff({
            pr = pr_number,
            on_show = function(picker)
              local items = picker:items()
              if items and #items > 0 then
                gh_diff_cache.picker_data[pr_number] = {
                  items = items,
                  last_opened = os.time(),
                }
              end
            end,
          })
        end
      end,
      desc = "GitHub: Current branch PR diff (cached)",
    },
    {
      "<leader>gD",
      function()
        clear_gh_diff_cache()
      end,
      desc = "GitHub: Clear diff cache",
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
