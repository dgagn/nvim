local M = {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
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
    },
    config = function()
      -- diagnostics
      local map = function(mode, keybind, fn, desc)
        if type(desc) ~= "table" then
          vim.keymap.set(mode, keybind, fn, { desc = desc })
        else
          vim.keymap.set(mode, keybind, fn, desc)
        end
      end

      map('n', '[d', vim.diagnostic.goto_prev, 'Goto previous diagnostic')
      map('n', ']d', vim.diagnostic.goto_next, 'Goto next diagnostic')
      map('n', 'gf', vim.diagnostic.open_float, 'Goto the float diagnostics')
      map('n', 'gF', require('telescope.builtin').diagnostics, 'Find all the float diagnostics')

      -- utils gotos
      map('n', 'gh', '0', 'Goto line start')
      map('n', 'gl', '$', 'Goto line end')
      map('n', 'gs', '^', 'Goto first non-blank in start')
      map('n', 'g;', 'g;', 'Goto older position in change list')
      map('n', 'g,', 'g,', 'Goto newer position in change list')

      local on_attach = function(_, bufnr)
        local lspmap = function(mode, keys, func, desc)
          map(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        lspmap('n', 'gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
        lspmap('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
        lspmap('n', 'gI', require('telescope.builtin').lsp_implementations, 'Goto implementation')
        lspmap('n', 'gt', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')
        lspmap('n', 'K', vim.lsp.buf.hover, 'Show hover information')

        lspmap('n', 'gr', require('telescope.builtin').lsp_references, 'Goto references')
        lspmap({ 'i', 'n' }, '<c-s>', vim.lsp.buf.signature_help, 'Show signature help')

        lspmap('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, 'Find document symbols')

        lspmap('n', '<leader>r', vim.lsp.buf.rename, 'Rename symbol')
        lspmap('n', '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, 'Format the code based on lsp')
        lspmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
      end

      local servers = {
        rust_analyzer = {},
        tsserver = {},
        clangd = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false }
          }
        },
        intelephense = {},
        tailwindcss = {},
        jsonls = {
          schemas = require('schemastore').json.schemas()
        },
      }

      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers)
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name]
          })
        end
      })
    end
  }
}


return M
