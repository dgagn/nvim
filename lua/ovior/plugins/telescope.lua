return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    },
    opts = {
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
        file_ignore_patterns = {
          'node_modules',
          'vendor',
          '.git/'
        },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      }
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end
  }
}
