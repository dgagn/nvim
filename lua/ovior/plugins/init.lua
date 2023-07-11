return {
  -- manages the indents
  'tpope/vim-sleuth',
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { '<C-h>', ':TmuxNavigateLeft<CR>',  desc = "Move to the left tmux pane" },
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
      'hrsh7th/nvim-cmp'
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
    'echasnovski/mini.splitjoin',
    opts = {}
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
      { '<leader>m', function() require('harpoon.mark').add_file() end, desc = 'Mark the file'},
      { '<c-e>', function() require('harpoon.ui').toggle_quick_menu() end, desc = 'Open the harpoon quick menu'},
      { 'g1', function() require('harpoon.ui').nav_file(1) end, desc = 'Goto the first file in the harpoon list'},
      { 'g2', function() require('harpoon.ui').nav_file(2) end, desc = 'Goto the second file in the harpoon list'},
      { 'g3', function() require('harpoon.ui').nav_file(3) end, desc = 'Goto the third file in the harpoon list'},
      { 'g4', function() require('harpoon.ui').nav_file(4) end, desc = 'Goto the fourth file in the harpoon list'},
    }
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Open the undotree' }
    }
  },
}
