return {
  -- manages the indents
  'tpope/vim-sleuth',
  'tpope/vim-unimpaired',
  'tpope/vim-repeat',
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
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('nvim-autopairs').setup({
        fast_wrap = {
          map = '<c-q>',
        }
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },
  {
    'echasnovski/mini.bufremove',
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
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      })
    end
  },
  {
    'ThePrimeagen/harpoon',
    opts = {},
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
          }, {})
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
    keys = {
      {
        '<leader>cr',
        function()
          require('spectre').open()
        end,
        desc = 'Show spectre'
      }
    }
  }
}
