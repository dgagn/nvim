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
      'windwp/nvim-autopairs',
    },
    event = 'InsertEnter',
    opts = function()
      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        experimental = {
          ghost_text = true,
        },
        snippet = {
          expand = function(args)
            local luasnip = require('luasnip')
            if not luasnip then
              return
            end
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<S-CR>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                cmp.confirm()
              end
            else
              fallback()
            end
          end, { "i", "s", "c", }),
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
  {
    'L3MON4D3/LuaSnip',
    after = 'nvim-cmp',
    config = function()
      local types = require('luasnip.util.types')
      require('luasnip').config.set_config({
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        history = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "← Current choice", "Comment" } },
            }
          }
        }
      })
      for index, value in ipairs(table) do

      end
      require('luasnip.loaders.from_lua').lazy_load({ paths = "~/.config/nvim/snips" })
      require('luasnip.loaders.from_snipmate').lazy_load()
    end,
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

          local _, col = unpack(vim.api.nvim_win_get_cursor(0))
          local content = vim.api.nvim_get_current_line()
          local character_before = content:sub(col, col)

          if character_before == "n" and content:sub(col - 5) == "return" then
            return '<space>'
          end

          if character_before == "f" and content:sub(col - 1) == "if" then
            return '<space>'
          end

          if vim.bo.filetype ~= "html" and vim.bo.filetype ~= "javascriptreact" and vim.bo.filetype ~= "typescriptreact" then
            return '<tab>'
          end

          local function last_word_valid(line, col)
            local line_before_cursor = line:sub(1, col)

            -- Find the last word in the line
            local _, _, last_word = string.find(line_before_cursor, "([^%s]+)%s*$")

            -- If there's no last word, return false
            if not last_word then return false end

            -- Check if the last word is camel case (contains an uppercase letter after a lowercase letter)
            if string.find(last_word, "%l%u") then return false end

            -- Check if the last word contains a digit
            if string.find(last_word, "[^%*=@%-]%d") then return false end

            -- If it passed all the checks, return true
            return true
          end

          local ts = require 'nvim-treesitter.ts_utils'

          local node_cursor = ts.get_node_at_cursor():type()
          local is_valid_jsx = vim.bo.filetype == "html" or
              (node_cursor == "statement_block" or node_cursor == "jsx_element" or node_cursor == "parenthesized_expression")

          if not last_word_valid(content, col) then
            return '<tab>'
          end

          if character_before ~= nil and character_before ~= " " and is_valid_jsx then
            return '<Plug>(emmet-expand-abbr)'
          end

          return '<tab>'
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' }
      },
      {
        '<tab>',
        function()
          local _, col = unpack(vim.api.nvim_win_get_cursor(0))
          local content = vim.api.nvim_get_current_line()
          local character_before = content:sub(col, col)

          if vim.bo.filetype ~= "html" and vim.bo.filetype ~= "javascriptreact" and vim.bo.filetype ~= "typescriptreact" then
            return '<tab>'
          end

          local ts = require 'nvim-treesitter.ts_utils'

          local node_cursor = ts.get_node_at_cursor():type()
          local is_valid_jsx = vim.bo.filetype == "html" or
              (node_cursor == "statement_block" or node_cursor == "jsx_element" or node_cursor == "parenthesized_expression" or node_cursor == "jsx_text")

          if character_before ~= nil and character_before ~= " " and is_valid_jsx then
            return '<Plug>(emmet-expand-abbr)'
          end

          return '<tab>'
        end,
        expr = true,
        silent = true,
        mode = { 'v' }
      },
      {
        '<s-tab>',
        function()
          local ls = require('luasnip')
          if ls.jumpable(-1) then
            ls.jump(-1)
          end

          return '<c-d>'
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
