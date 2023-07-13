return {
  -- manages the indents
  'tpope/vim-sleuth',
  {'tpope/vim-unimpaired', event = "VeryLazy"},
  {'tpope/vim-repeat', event = "VeryLazy"},
  {
    'mattn/emmet-vim',
    ft = { "html", 'javascriptreact', 'typescriptreact' },
  },
  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
      vim.g.splitjoin_trailing_comma = 1
      vim.g.splitjoin_php_method_chain_full = 1
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { '<C-h>', ':TmuxNavigateLeft<CR>',  desc = 'Move to the left tmux pane' },
      { '<C-j>', ':TmuxNavigateDown<CR>',  desc = "Move to the down tmux pane" },
      { '<C-k>', ':TmuxNavigateUp<CR>',    desc = "Move to the up tmux pane" },
      { '<C-l>', ':TmuxNavigateRight<CR>', desc = "Move to the right tmux pane" },
    }
  },
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gs', vim.cmd.Git, desc = 'Open git status' }
    }
  },
  {
    'folke/which-key.nvim',
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = function()
      -- local pairs = require('nvim-autopairs')
      -- pairs.setup({
      --   fast_wrap = {
      --     map = '<c-q>',
      --   },
      -- })
    end
  },
  {
    'echasnovski/mini.bufremove',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>x', function() require("mini.bufremove").delete(0, false) end, desc = "Delete the current buffer" }
    }
  },
  {
    'tpope/vim-surround',
    event = 'VeryLazy'
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  }, {
  'ThePrimeagen/harpoon',
  opts = {},
  event = 'VeryLazy',
  keys = {
    { '<leader>m', function() require('harpoon.mark').add_file() end,        desc = 'Mark the file' },
    { '<c-e>',     function() require('harpoon.ui').toggle_quick_menu() end, desc = 'Open the harpoon quick menu' },
    {
      'g1',
      function() require('harpoon.ui').nav_file(1) end,
      desc =
      'Goto the first file in the harpoon list'
    },
    {
      'g2',
      function() require('harpoon.ui').nav_file(2) end,
      desc =
      'Goto the second file in the harpoon list'
    },
    {
      'g3',
      function() require('harpoon.ui').nav_file(3) end,
      desc =
      'Goto the third file in the harpoon list'
    },
    {
      'g4',
      function() require('harpoon.ui').nav_file(4) end,
      desc =
      'Goto the fourth file in the harpoon list'
    },
  }
},
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    -- event = 'VeryLazy',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Open the undotree' }
    },
  },
  {
    'echasnovski/mini.ai',
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function()
      local ai = require('mini.ai')

      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.outer", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner"
          }, {}),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner"
          }, {}),
          a = ai.gen_spec.treesitter({
            i = "@parameter.inner",
            a = "@parameter.outer",
          }, {}),
        }
      }
    end
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
    },
    -- event = 'VeryLazy',
    keys = {
      {
        '<leader>cr',
        function()
          require('spectre').open()
        end,
        desc = 'Show spectre'
      }
    }
  },
  {
    'mizlan/iswap.nvim',
    cmd = {'ISwapWith', 'ISwapNodeWith'},
    -- event = 'VeryLazy',
    opts = {
      grey = 'disable',
    },
    keys = {
      { '<leader>aa', vim.cmd.ISwapWith,     desc = 'Arrange the argument orders' },
      { '<leader>an', vim.cmd.ISwapNodeWith, desc = 'Arrange the node orders' },
    }
  },
  {
    'voldikss/vim-floaterm',
    cmd = 'FloatermToggle',
    config = function ()
      vim.g.floaterm_height = 0.4
      vim.g.floaterm_wintype = 'split'
    end,
    keys = {
      { '<F1>', vim.cmd.FloatermToggle, mode = 'n' },
      { '<F1>', '<esc><cmd>FloatermToggle<cr>', mode = 'i' },
      { '<F1>', '<C-\\><C-n><cmd>FloatermToggle<cr>', mode = 't' },
    }
  },
}
