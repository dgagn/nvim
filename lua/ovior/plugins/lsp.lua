local M = {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true
      },
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',

      -- status update for neovim
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {}
      },
      {
        'folke/neodev.nvim',
        opts = {}
      }
    }
  }
}


return M
