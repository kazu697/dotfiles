return {
  {
    "hrsh7th/nvim-cmp",                 -- 補完エンジン本体
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",          -- LSP を設定するためのプラグイン（LSP を使うなら追加）
      "hrsh7th/cmp-nvim-lsp",           -- LSP 補完ソース
      "hrsh7th/cmp-buffer",             -- バッファ補完
      "hrsh7th/cmp-path",               -- パス補完
      "hrsh7th/cmp-cmdline",            -- コマンドライン補完
      "L3MON4D3/LuaSnip",               -- スニペットエンジン
      "saadparwaiz1/cmp_luasnip",       -- LuaSnip 用補完ソース
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip/loaders/from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]     = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- コマンドライン補完
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
      })
    end,
  },
}
