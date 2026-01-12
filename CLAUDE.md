# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

macOS向けのdotfilesリポジトリ。以下の設定を管理:
- Neovim (LazyVim)
- mise (ツールバージョン管理)
- Homebrew パッケージ
- ターミナル (Ghostty, tmux)
- シェル (starship, sheldon)
- Claude Code グローバル設定
- Git設定

## セットアップコマンド

```bash
# miseタスクによるセットアップ（推奨）
mise run setup              # すべてのシンボリックリンク作成
mise run setup:config       # .config/** -> ~/.config/**
mise run setup:home         # home/** -> ~/**
mise run link <src> <dest>  # 任意のディレクトリをリンク

# Homebrew パッケージのインストール
brew bundle --file=.Brewfile
```

## アーキテクチャ

### ディレクトリ構成

```
dotfiles/
├── .config/                    # ~/.config/ にリンクされる設定
│   ├── nvim/                   # Neovim設定 (LazyVim)
│   ├── mise/                   # mise グローバルツール設定
│   ├── .claude/                # Claude Code グローバル設定
│   ├── ghostty/                # Ghosttyターミナル設定
│   ├── tmux/                   # tmux設定
│   └── starship.toml           # Starshipプロンプト設定
├── home/                       # ~/ にリンクされるファイル
│   └── .gitconfig              # Git設定
├── config/
│   └── sheldon/                # Sheldon (zshプラグインマネージャ)
├── .claude/                    # このリポジトリ用Claude Code設定
├── .Brewfile                   # Homebrew パッケージ定義
└── mise.toml                   # miseタスク定義
```

### Neovim設定構造 (LazyVim)

LazyVimをベースとしたNeovim設定:

- `.config/nvim/init.lua` - エントリーポイント
- `.config/nvim/lua/config/lazy.lua` - lazy.nvimブートストラップ + LazyVim読み込み
- `.config/nvim/lua/config/options.lua` - エディタオプション
- `.config/nvim/lua/config/keymaps.lua` - カスタムキーマップ
- `.config/nvim/lua/config/autocmds.lua` - 自動コマンド
- `.config/nvim/lua/plugins/*.lua` - カスタムプラグイン設定
  - `snacks.lua` - Snacks.nvim (ファイラー、picker、GitHub PR差分)
  - `go.lua` - Go開発設定
  - `formatting.lua` - フォーマッター設定
  - `treesitter.lua` - Tree-sitter設定
- `.config/nvim/after/lsp/*.lua` - 個別LSPサーバー設定
  - `gopls.lua` - Go LSP
  - `lua_ls.lua` - Lua LSP
  - `markdown_oxide.lua` - Markdown LSP

### mise設定

**グローバルツール** (`.config/mise/config.toml`):
- fd, go (1.24.0), node (22.14.0), ripgrep

**タスク** (`mise.toml`):
- `setup` - dotfilesのシンボリックリンク作成
- `link` - 任意ディレクトリのリンク作成

### Claude Code設定

**グローバル設定** (`.config/.claude/`):
- `CLAUDE.md` - グローバル指示（日本語コミットメッセージ、品質基準など）
- `settings.json` - 権限設定、フック（通知）、ステータスライン

**リポジトリ設定** (`.claude/`):
- `settings.json` - このリポジトリ用の追加権限

### ターミナル・シェル設定

- **Ghostty** (`.config/ghostty/config`): Solarized Dark、Consolas、vim風キーバインド
- **tmux** (`.config/tmux/tmux.conf`): vi-mode、vim風ペイン操作
- **Starship** (`.config/starship.toml`): Git情報、実行時間、時刻表示
- **Sheldon** (`config/sheldon/plugins.toml`): zsh-autosuggestions, fast-syntax-highlighting

## 開発言語とツール

このリポジトリのユーザーは主にGoとTypeScript/Node.jsで開発。

### Go開発
- golangci-lint, gopls, staticcheck, mockgen, swag, delve, enumer

### エディタ・CLI
- Neovim + LazyVim + lazy.nvim
- gh (GitHub CLI)
- fzf, peco, jq

### その他
- uv (Python), tfenv (Terraform), awscli

## コーディング規約

- コミットメッセージは日本語で、1行目は簡潔に
- Co-Authored-By は含めない
- テストコードを追加・修正した場合はテストを実行する
- 同階層のファイル実装を参考にする
