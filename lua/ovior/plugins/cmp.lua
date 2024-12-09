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
        },
        toggle_key_flip_floatwin_setting = true,
        toggle_key = "<c-k>"
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
      local compare = require("cmp.config.compare")
      -- local config = require("ovior.configs.cmp")

      -- cmp.setup.filetype({ "rust" }, {
      --   sorting = {
      --     priority_weight = 2,
      --     comparators = {
      --       -- deprioritize `.box`, `.mut`, etc.
      --       config.deprioritize_postfix,
      --       -- deprioritize `Borrow::borrow` and `BorrowMut::borrow_mut`
      --       config.deprioritize_borrow,
      --       -- deprioritize `Deref::deref` and `DerefMut::deref_mut`
      --       config.deprioritize_deref,
      --       -- deprioritize `Into::into`, `Clone::clone`, etc.
      --       config.deprioritize_common_traits,
      --       compare.offset,
      --       compare.exact,
      --       compare.score,
      --       compare.recently_used,
      --       compare.locality,
      --       compare.sort_text,
      --       compare.length,
      --       compare.order,
      --     }
      --   }
      -- })

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
          ['<c-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<c-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
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
