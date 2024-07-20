local M = {
  {
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require "lsp_signature".setup({
				doc_lines = 0,
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        }
			})
		end
	},
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- snippets and cmp
      -- "hrsh7th/cmp-nvim-lsp-signature-help",

      -- buffer and path
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<S-CR>"] = cmp.mapping(function(fallback)
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
          end, { "i", "s", "c" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = "luasnip" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
          { name = "ultisnips" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },
  {
    "SirVer/ultisnips",
    dependencies = { "nvim-cmp" }
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enable = true,
        auto_trigger = true,
        keymap = {
          accept = "<c-u>",
          next = "<c-g>",
          prev = "<c-f>",
          dismiss = "<c-e>",
        },
      },
      panel = {
        enable = false,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
}

return M
