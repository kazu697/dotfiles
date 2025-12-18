-- アイコン表示用プラグイン (Nerd Fonts必須)
return {
	"nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = {
		-- デフォルトのアイコンを有効化
		default = true,
		-- ファイルタイプ毎の色を有効化
		color_icons = true,
	},
}
