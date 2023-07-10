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

  lspmap('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
  lspmap('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
  lspmap('n', 'gi', vim.lsp.buf.implementation, 'Goto implementation')
  lspmap('n', 'gy', vim.lsp.buf.type_definition, 'Goto type definition')

  lspmap('n', 'gr', require('telescope.builtin').lsp_references, 'Goto references')
  lspmap({ 'i', 'n' }, '<c-s>', vim.lsp.buf.signature_help, 'Show signature help')

  lspmap('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, 'Find document symbols')

  lspmap('n', '<leader>r', vim.lsp.buf.rename, 'Rename symbol')
  lspmap('n', '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, 'Format the code based on lsp')
  lspmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')

  lspmap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Find workspace symbols')
  lspmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
  lspmap('n', '<leader>wd', vim.lsp.buf.remove_workspace_folder, 'Delete workspace folder')
  lspmap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List workspace folders')
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
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers)
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name]
    })
  end
})
