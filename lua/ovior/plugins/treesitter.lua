return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    },
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      ensure_installed = { "python", "lua", "typescript", "javascript", "json", "yaml", "html", "css", "bash", "c", "cpp", "rust", "go", "java", "toml", "jsonc" },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "+",
          node_incremental = "+",
          scope_incremental = "s+",
          node_decremental = "s-",
        },
      },
      autotag = {
        enable = true,
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")

      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.outer", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }, {}),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }, {}),
          a = ai.gen_spec.treesitter({
            i = "@parameter.inner",
            a = "@parameter.outer",
          }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  }
}
