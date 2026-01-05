local M = {}

--- 現在開いているファイルの相対パスを取得する
--- カレントディレクトリ（vim.fn.getcwd()）からの相対パスを返す
--- @return string 相対パス。バッファにファイルがない場合は空文字列
function M.get_relative_path()
	local absolute_path = vim.fn.expand("%:p")
	if absolute_path == "" then
		return ""
	end

	local cwd = vim.fn.getcwd()
	-- fnamemodify で相対パスに変換
	local relative_path = vim.fn.fnamemodify(absolute_path, ":.")

	return relative_path
end

--- 現在開いているファイルの相対パスをクリップボードにコピーする
function M.copy_relative_path()
	local path = M.get_relative_path()
	if path == "" then
		vim.notify("ファイルが開かれていません", vim.log.levels.WARN)
		return
	end

	vim.fn.setreg("+", path)
	vim.notify("コピーしました: " .. path, vim.log.levels.INFO)
end

--- Gitリポジトリのルートディレクトリを取得する
--- @return string|nil リポジトリルート。Gitリポジトリでない場合はnil
function M.get_git_root()
	local result = vim.fn.systemlist("git rev-parse --show-toplevel")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return result[1]
end

--- GitHubのリモートURLを取得してHTTPS形式に変換する
--- @return string|nil GitHubのベースURL（例: https://github.com/user/repo）
function M.get_github_base_url()
	local result = vim.fn.systemlist("git remote get-url origin")
	if vim.v.shell_error ~= 0 or #result == 0 then
		return nil
	end

	local remote_url = result[1]

	-- SSH形式（git@github.com:user/repo.git）をHTTPS形式に変換
	if remote_url:match("^git@github%.com:") then
		remote_url = remote_url:gsub("^git@github%.com:", "https://github.com/")
	end

	-- .git 拡張子を削除
	remote_url = remote_url:gsub("%.git$", "")

	return remote_url
end

--- 現在のコミットハッシュを取得する
--- @return string|nil コミットハッシュ
function M.get_commit_hash()
	local result = vim.fn.systemlist("git rev-parse HEAD")
	if vim.v.shell_error ~= 0 or #result == 0 then
		return nil
	end
	return result[1]
end

--- ファイルのGitリポジトリルートからの相対パスを取得する
--- @return string|nil 相対パス
function M.get_file_path_from_git_root()
	local git_root = M.get_git_root()
	if not git_root then
		return nil
	end

	local absolute_path = vim.fn.expand("%:p")
	if absolute_path == "" then
		return nil
	end

	-- Gitルートからの相対パスを計算
	local relative_path = absolute_path:sub(#git_root + 2) -- +2 for trailing slash
	return relative_path
end

--- 現在のカーソル位置のGitHub permalinkを生成する
--- ビジュアルモードで選択している場合は範囲を含む
--- @param start_line number|nil ビジュアルモードの開始行
--- @param end_line number|nil ビジュアルモードの終了行
--- @return string|nil permalink URL
function M.get_github_permalink(start_line, end_line)
	local github_url = M.get_github_base_url()
	if not github_url then
		return nil
	end

	local commit_hash = M.get_commit_hash()
	if not commit_hash then
		return nil
	end

	local file_path = M.get_file_path_from_git_root()
	if not file_path then
		return nil
	end

	local line_ref
	if start_line and end_line then
		-- ビジュアルモードの場合、選択範囲を使用
		if start_line == end_line then
			line_ref = "L" .. start_line
		else
			-- 開始行が終了行より大きい場合（下から上に選択した場合）を考慮
			local min_line = math.min(start_line, end_line)
			local max_line = math.max(start_line, end_line)
			line_ref = "L" .. min_line .. "-L" .. max_line
		end
	else
		-- ノーマルモードの場合、現在行のみ
		local line = vim.fn.line(".")
		line_ref = "L" .. line
	end

	return string.format("%s/blob/%s/%s#%s", github_url, commit_hash, file_path, line_ref)
end

--- GitHub permalinkをクリップボードにコピーする
--- @param start_line number|nil ビジュアルモードの開始行
--- @param end_line number|nil ビジュアルモードの終了行
function M.copy_github_permalink(start_line, end_line)
	local permalink = M.get_github_permalink(start_line, end_line)
	if not permalink then
		vim.notify("GitHub permalinkを生成できませんでした（Gitリポジトリではない可能性があります）", vim.log.levels.WARN)
		return
	end

	vim.fn.setreg("+", permalink)
	vim.notify("コピーしました: " .. permalink, vim.log.levels.INFO)
end

return M
