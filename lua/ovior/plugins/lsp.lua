local M = {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        php = { "pint" },
        sql = { "sql_formatter" },
        typescript = { { "prettier", "prettierd" } },
        astro = { { "prettier", "prettierd" } },
        typescriptreact = { { "prettier", "prettierd" } },
        javascriptreact = { { "prettier", "prettierd" } },
        javascript = { { "prettier", "prettierd" } },
      },
      formatters = {
        rustfmt = {
          prepend_args = { "--edition", "2021" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        sql_formatter = {
          prepend_args = { "--config", "/Users/danygagnon/.sql/format.json" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
      },
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      -- status update for neovim
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {},
      },
      {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
      },
      {
        "folke/neodev.nvim",
        opts = {},
      },
      "rust-lang/rust.vim",
      "simrat39/rust-tools.nvim",
      -- {
      --   "jose-elias-alvarez/null-ls.nvim",
      --   event = { "BufReadPre", "BufNewFile" },
      --   dependencies = { "mason.nvim", "simrat39/rust-tools.nvim" },
      --   opts = function()
      --     local nls = require("null-ls")
      --     return {
      --       root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      --       sources = {
      --         -- nls.builtins.diagnostics.eslint,
      --       },
      --     }
      --   end,
      -- },
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

      map("n", "<leader>fm", function()
        require("conform").format({ async = true, fallback_lsp = true })
      end, "Format the code based on lsp")

      local on_attach = function(client, bufnr)
        local lspmap = function(mode, keys, func, desc)
          map(mode, keys, func, { buffer = bufnr, desc = desc })
        end
        map("n", "[d", vim.diagnostic.goto_prev, "Goto previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Goto next diagnostic")

        map("n", "gf", vim.diagnostic.open_float, "Goto the float diagnostics")
        map("n", "gF", require("telescope.builtin").diagnostics, "Find all the float diagnostics")

        map("n", "<leader>z", "<cmd>LspRestart<cr>", "Restart the LSP")

        -- utils gotos
        map("n", "g;", "g;", "Goto older position in change list")
        map("n", "g,", "g,", "Goto newer position in change list")

        lspmap("n", "gd", require("telescope.builtin").lsp_definitions, "Goto definition")
        lspmap("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
        lspmap("n", "gi", require("telescope.builtin").lsp_implementations, "Goto implementation")
        lspmap("n", "gt", require("telescope.builtin").lsp_type_definitions, "Goto type definition")
        lspmap("n", "K", vim.lsp.buf.hover, "Show hover information")

        lspmap("n", "gr", require("telescope.builtin").lsp_references, "Goto references")
        lspmap({ "i", "n" }, "<c-s>", vim.lsp.buf.signature_help, "Show signature help")

        lspmap("n", "<leader>fs", require("telescope.builtin").lsp_document_symbols, "Find document symbols")

        lspmap("n", "<leader>r", vim.lsp.buf.rename, "Rename symbol")
        lspmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

        lspmap("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Find workspace symbols")
      end

      local servers = {
        wgsl_analyzer = {},
        rust_analyzer = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              allFeatures = true,
              autoreload = true,
              runBuildScripts = true,
            },
            completion = {
              autoimport = {
                enable = true,
              },
              postfix = {
                enable = false,
              },
            },
            diagnostics = {
              enable = true,
              disabled = { "macro-error", "unresolved-proc-macro" },
              enableExperimental = true,
            },
            procMacro = {
              enable = true,
            },
            rustcSource = "discover",
            updates = {
              channel = "nightly",
            },
          },
        },
        pylsp = {},
        sqlls = {},
        tsserver = {},
        astro = {},
        clangd = {},
        html = {
          format = {
            templating = true,
            wrapLineLength = 120,
            wrapAttributes = "auto",
          },
          hover = {
            documentation = true,
            references = true,
          },
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        intelephense = {},
        tailwindcss = {},
        jsonls = {
          schemas = require("schemastore").json.schemas(),
        },
        jdtls = {},
      }

      require("rust-tools").setup({
        tools = {
          autoSetHints = false,
          inlay_hints = {
            auto = false,
            only_current_line = false,
            show_parameter_hints = false,
            parameter_hints_prefix = "< ",
            other_hints_prefix = " ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "DimComment",
          },
        },
        server = {
          standalone = false,
        },
      })

      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })
    end,
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },
}

return M
