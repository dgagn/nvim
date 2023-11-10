return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
      {
        "nvim-treesitter/nvim-treesitter-context",
        init = function()
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
      -- {
      --   'windwp/nvim-ts-autotag',
      --   opts = {
      --     enable = true,
      --     enable_rename = true,
      --     enable_close_on_slash = false,
      --   }
      -- },
      {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        config = function()
          require("nvim-treesitter.configs").setup({})
        end,
      },
    },
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      ensure_installed = "all",
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Esc>wW",
          node_incremental = "<Esc>wW",
          node_decremental = "<m-space>",
        },
      },
      context_commentstring = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    },
  },
}
