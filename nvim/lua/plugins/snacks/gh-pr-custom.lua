-- カスタムPRピッカー
-- 自分が作成したPRとレビューリクエストされたPRを表示

local M = {}

-- URLからリポジトリ情報を抽出（例: https://github.com/owner/repo/pull/123 -> owner/repo）
---@param url string
---@return string|nil
local function extract_repo_from_url(url)
  local owner, repo = url:match("github%.com/([^/]+)/([^/]+)/pull")
  if owner and repo then
    return owner .. "/" .. repo
  end
  return nil
end

-- PRの差分をプレビューとして表示
---@param ctx snacks.picker.preview.ctx
local function preview_pr_diff(ctx)
  local item = ctx.item
  if not item or not item.number then
    return
  end

  -- プレビューバッファにローディング表示
  ctx.preview:set_lines({ "Loading PR diff..." })

  -- URLからリポジトリを取得
  local repo = item.repo
  if not repo then
    ctx.preview:set_lines({ "Failed to load diff", "Repository not found" })
    return
  end

  -- gh pr diffコマンドで差分を取得（--repoオプションでリポジトリを指定）
  vim.system(
    { "gh", "pr", "diff", tostring(item.number), "--repo", repo },
    { text = true },
    function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          ctx.preview:set_lines({ "Failed to load diff", result.stderr or "" })
          return
        end

        local lines = vim.split(result.stdout or "", "\n")
        ctx.preview:set_lines(lines)
        -- diffのシンタックスハイライトを適用
        local buf = ctx.preview.win.buf
        if buf and vim.api.nvim_buf_is_valid(buf) then
          vim.bo[buf].filetype = "diff"
        end
      end)
    end
  )
end

-- ghコマンドでPR一覧を取得してピッカーで表示
---@param opts { title: string, args: string[] }
local function pick_prs(opts)
  -- 現在のリポジトリに対してgh pr listを実行
  local cmd = {
    "gh", "pr", "list",
    "--json", "number,title,headRefName,url,author,state",
    "--limit", "100",
  }
  -- 追加の引数をマージ
  for _, arg in ipairs(opts.args or {}) do
    table.insert(cmd, arg)
  end

  -- ghコマンドを実行
  vim.system(cmd, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify("gh pr list failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
        return
      end

      local ok, prs = pcall(vim.json.decode, result.stdout)
      if not ok or not prs then
        vim.notify("Failed to parse PR list", vim.log.levels.ERROR)
        return
      end

      if #prs == 0 then
        vim.notify("No PRs found", vim.log.levels.INFO)
        return
      end

      -- Snacks.pickerでPR一覧を表示
      Snacks.picker({
        source = "gh_pr_custom",
        title = opts.title,
        items = vim.tbl_map(function(pr)
          return {
            text = string.format("#%d %s (%s)", pr.number, pr.title, pr.headRefName),
            number = pr.number,
            title = pr.title,
            branch = pr.headRefName,
            url = pr.url,
            author = pr.author.login,
            repo = extract_repo_from_url(pr.url),
          }
        end, prs),
        format = function(item)
          return {
            { "#" .. item.number, "Number" },
            { " " },
            { item.title, "Title" },
            { " (" .. item.branch .. ")", "Comment" },
          }
        end,
        -- PRの差分をプレビュー表示
        preview = preview_pr_diff,
        confirm = function(picker, item)
          if not item then return end
          picker:close()
          -- gh pr checkoutを実行
          vim.system({ "gh", "pr", "checkout", tostring(item.number) }, { text = true }, function(res)
            vim.schedule(function()
              if res.code == 0 then
                vim.notify("Checked out PR #" .. item.number .. ": " .. item.title)
              else
                vim.notify("Error: " .. (res.stderr or "unknown error"), vim.log.levels.ERROR)
              end
            end)
          end)
        end,
      })
    end)
  end)
end

-- 自分が作成したPR（現在のリポジトリ）
function M.my_prs()
  pick_prs({
    title = "My Open PRs",
    args = { "--author", "@me", "--state", "open" },
  })
end

-- レビューリクエストされたPR（現在のリポジトリ）
function M.review_requested_prs()
  pick_prs({
    title = "Review Requested PRs",
    args = { "--search", "review-requested:@me", "--state", "open" },
  })
end

return M
