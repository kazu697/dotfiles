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

return M
