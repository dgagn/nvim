local M = {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- snippets and cmp
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- buffer and path
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- add copilot

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enable = false
      },
      panel = {
        enable = false
      }
    },
    config = function(_, opts)
      require('copilot').setup(opts)
    end
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  }
}



return M
