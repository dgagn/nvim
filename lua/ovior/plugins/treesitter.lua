return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      {
        'nvim-treesitter/nvim-treesitter-context',
        init = function()
          require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
        end
      },
      {
        'windwp/nvim-ts-autotag',
        opts = {}
      }
    },
    build = ':TSUpdate',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
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
    }
  }
}
