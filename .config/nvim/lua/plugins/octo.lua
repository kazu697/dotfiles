-- GitHub integration with Octo.nvim
return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    keys = {
      { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List Issues" },
      { "<leader>gI", "<cmd>Octo issue create<cr>", desc = "Create Issue" },
      { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gP", "<cmd>Octo pr create<cr>", desc = "Create PR" },
      { "<leader>gr", "<cmd>Octo review start<cr>", desc = "Start Review" },
    },
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      ssh_aliases = {},
      picker = "snacks",
      use_local_fs = true,
      gh_env = {
        GH_PAGER = "",
      },
      timeout = 10000,
      issues = {
        order_by = {
          field = "UPDATED_AT",
          direction = "DESC",
        },
      },
      pull_requests = {
        order_by = {
          field = "UPDATED_AT",
          direction = "DESC",
        },
      },
    },
  },
}
