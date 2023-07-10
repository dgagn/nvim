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
      require('nvim-autopairs').setup({})
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
  } }
