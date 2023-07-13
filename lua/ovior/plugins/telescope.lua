return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'live_grep_args')
    end,
    keys = function()
      local builtin = require('telescope.builtin')

      return {
        {
          '<leader>ff',
          builtin.find_files,
          desc = 'Find files'
        },
        {
          '<leader>fb',
          builtin.buffers,
          desc = 'Find in buffers',
        },
        {
          '<leader>fg',
          builtin.live_grep,
          desc = 'Find live grep',
        },
        {
          '<leader>fw',
          builtin.grep_string,
          desc = 'Find current word',
        },
        {
          '<leader>fd',
          builtin.diagnostics,
          desc = 'Find diagnostics',
        },
        {
          '<leader>fh',
          builtin.help_tags,
          desc = 'Find help tags',
        },
        {
          '<leader>?',
          builtin.oldfiles,
          desc = 'Find recently opened files',
        },
        {
          '<leader>hh',
          builtin.help_tags,
          desc = 'Find help for a command'
        },
        {
          '<leader>/',
          function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
              winblend = 10,
              previewer = false,
            }))
          end,
          desc = 'Find recently opened files'
        }
      }
    end,
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
