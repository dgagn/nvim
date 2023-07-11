return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {}
      },
      {
        'windwp/nvim-ts-autotag',
        opts = {}
      }
    },
    build = ':TSUpdate',
    config = function ()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c',
          'lua',

          'rust',
          'python',
          'php',

          'tsx',
          'typescript',
          'javascript',
          'html'
        },
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<Esc>wW',
            node_incremental = '<Esc>wW',
            node_decremental = '<m-space>'
          }
        },
        context_commentstring = {
          enable = true
        },
        autotag = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aC'] = '@class.outer',
              ['iC'] = '@class.inner',
            }
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']c'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']C'] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[c'] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[C'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>sa'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>sA'] = '@parameter.inner',
            },
          },
        },
      })
    end
  }
}
