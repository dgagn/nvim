local M = {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- snippets and cmp
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',

      -- buffer and path
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    opts = function()
      local cmp = require('cmp')

      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
        }, {
          { name = 'buffer' }
        }),
      }
    end
  },
  'saadparwaiz1/cmp_luasnip',
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        -- require('luasnip').filetype_extend("typescriptreact", { "html" })
      end,
    },
    opts = {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
    },
    keys = {
      {
        '<tab>',
        function()
          if require('luasnip').expand_or_jumpable() then
            return '<Plug>luasnip-expand-or-jump'
          end
          return '<tab>'
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' }
      },
      {
        '<s-tab>',
        function()
          local ls = require('luasnip')
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end,
        silent = true,
        expr = true,
        mode = { 'i', 's' }
      },
      {
        '<c-l>',
        function()
          local ls = require('luasnip')
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        mode = 'i',
        silent = true
      }
    }
  },
}

return M
