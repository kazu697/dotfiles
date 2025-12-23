# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

macOS向けのdotfilesリポジトリ。Neovim設定、mise（ツールバージョン管理）、Homebrew設定を管理。

## セットアップコマンド

```bash
# 初期セットアップ（シンボリックリンク作成 + mise インストール）
./install.sh

# Homebrew パッケージのインストール
brew bundle --file=.Brewfile
```

## アーキテクチャ

### ディレクトリ構成
- `nvim/` - Neovim設定（`~/.config/nvim`にシンボリックリンク）
- `mise/` - miseツールバージョン設定（`~/.config/mise`にシンボリックリンク）
- `config/.claude/` - Claude Codeのグローバル設定
- `.Brewfile` - Homebrew tap、brew、cask、vscode拡張、goパッケージの定義

### Neovim設定構造
- `nvim/init.lua` - エントリーポイント
- `nvim/lua/config/lazy.lua` - lazy.nvim（プラグインマネージャ）のブートストラップ
- `nvim/lua/config/base.lua` - 基本設定（キーマップ、オプション）
- `nvim/lua/config/lsp.lua` - LSP設定
- `nvim/lua/plugins/*.lua` - 各プラグイン設定（lazy.nvimが自動読み込み）
- `nvim/lsp/*.lua` - 個別LSPサーバー設定（gopls、lua_ls）

### mise設定
`mise/config.toml`でグローバルツールバージョンを管理:
- claude-code, fd, go, node, ripgrep

## 開発言語とツール

このリポジトリのユーザーは主にGoとTypeScript/Node.jsで開発。関連ツール:
- golangci-lint, gopls, staticcheck, mockgen, swag（Go開発）
- neovim + lazy.nvim（エディタ）
- gh（GitHub CLI）
