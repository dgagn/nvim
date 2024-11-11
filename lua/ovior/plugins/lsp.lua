local M = {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mfussenegger/nvim-dap"
    }
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
      'skywind3000/asyncrun.vim',
      {
        "rust-lang/rust.vim",
        ft = "rust",
        config = function()
          -- vim.g.rustfmt_autosave = 1
          vim.g.rustfmt_emit_files = 1
          vim.g.rustfmt_fail_silently = 0
          vim.g.rust_clip_command = 'wl-copy'
        end
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim", "simrat39/rust-tools.nvim" },
        opts = function()
          local nls = require("null-ls")
          return {
            root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
            sources = {
              nls.builtins.diagnostics.eslint,
              nls.builtins.formatting.prettier,
              -- nls.builtins.diagnostics.checkstyle.with({
              --   extra_args = { "-c", "/home/ovior/school/inf2050/session/src/main/resources/checkstyle.xml" }
              -- }),
            },
          }
        end,
      },
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

      local on_attach = function(client, bufnr)
        local lspmap = function(mode, keys, func, desc)
          map(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        map("n", "<leader>fm", function()
          local ft = vim.bo.filetype
          if ft == "java" then
            local jdtls = require('jdtls')
            jdtls.organize_imports()
          end
          vim.lsp.buf.format({ bufnr = bufnr, id=client.id })
        end, "Format the code based on lsp")

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

      local function get_jdtls()
        local mason_registry = require('mason-registry')
        local jdtls = mason_registry.get_package('jdtls')
        local jdtls_path = jdtls:get_install_path()
        local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
        local system = "linux"
        local config = jdtls_path .. "/config_" .. system
        return launcher, config
      end

			local function get_bundles()
				-- Get the Mason Registry to gain access to downloaded binaries
				local mason_registry = require("mason-registry")
				-- Find the Java Debug Adapter package in the Mason Registry
				local java_debug = mason_registry.get_package("java-debug-adapter")
				-- Obtain the full path to the directory where Mason has downloaded the Java Debug Adapter binaries
				local java_debug_path = java_debug:get_install_path()

				local bundles = {
          vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
				}

				-- Find the Java Test package in the Mason Registry
				local java_test = mason_registry.get_package("java-test")
				-- Obtain the full path to the directory where Mason has downloaded the Java Test binaries
				local java_test_path = java_test:get_install_path()
				-- Add all of the Jars for running tests in debug mode to the bundles list
				vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

				return bundles
			end


			local function get_workspace()
				-- Get the home directory of your operating system
				local home = os.getenv "HOME"
				-- Declare a directory where you would like to store project information
				local workspace_path = home .. "/code/workspace/"
				-- Determine the project name
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				-- Create the workspace directory by concatenating the designated workspace path and the project name
				local workspace_dir = workspace_path .. project_name
				return workspace_dir
			end

      local function setup_jdtls()
        -- Get access to the jdtls plugin and all of its functionality
        local jdtls = require("jdtls")

        -- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
        local launcher, os_config = get_jdtls()

        -- Get the path you specified to hold project information
        local workspace_dir = get_workspace()

        -- Get the bundles list with the jars to the debug adapter, and testing adapters
        local bundles = get_bundles()

        -- Determine the root directory of the project by looking for these specific markers
        local root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' });

        -- Tell our JDTLS language features it is capable of
        local capabilities = {
            workspace = {
                configuration = true
            },
            textDocument = {
                completion = {
                    snippetSupport = false
                }
            }
        }

        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

        for k, v in pairs(lsp_capabilities) do capabilities[k] = v end

        -- Get the default extended client capablities of the JDTLS language server
        local extendedClientCapabilities = jdtls.extendedClientCapabilities
        -- Modify one property called resolveAdditionalTextEditsSupport and set it to true
        extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        -- Set the command that starts the JDTLS language server jar
        local cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xmx1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-jar',
            launcher,
            '-configuration',
            os_config,
            '-data',
            workspace_dir
        }

        -- Configure settings in the JDTLS server
        local settings = {
            java = {
                -- Enable code formatting
                format = {
                    enabled = true,
                    -- Use the Google Style guide for code formatting
                    settings = {
                        url = vim.fn.stdpath("config") .. "/lang_servers/intellij-google-style.xml",
                        profile = "GoogleStyle"
                    }
                },
                -- Enable downloading archives from eclipse automatically
                eclipse = {
                    downloadSource = true
                },
                -- Enable downloading archives from maven automatically
                maven = {
                    downloadSources = true
                },
                -- Enable method signature help
                signatureHelp = {
                    enabled = true
                },
                -- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
                contentProvider = {
                    preferred = "fernflower"
                },
                -- Setup automatical package import oranization on file save
                saveActions = {
                    organizeImports = false
                },
                -- Customize completion options
                completion = {
                    -- When using an unimported static method, how should the LSP rank possible places to import the static method from
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                    -- Try not to suggest imports from these packages in the code action window
                    filteredTypes = {
                        "com.sun.*",
                        "io.micrometer.shaded.*",
                        "java.awt.*",
                        "jdk.*",
                        "sun.*",
                    },
                    -- Set the order in which the language server should organize imports
                    importOrder = {
                    }
                },
                sources = {
                    -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
                    organizeImports = {
                        starThreshold = 9999,
                        staticThreshold = 9999
                    }
                },
                -- How should different pieces of code be generated?
                codeGeneration = {
                    -- When generating toString use a json format
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                    },
                    -- When generating hashCode and equals methods use the java 7 objects method
                    hashCodeEquals = {
                        useJava7Objects = true
                    },
                    -- When generating code use code blocks
                    useBlocks = true
                },
                -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
                configuration = {
                    updateBuildConfiguration = "interactive"
                },
                -- enable code lens in the lsp
                referencesCodeLens = {
                    enabled = true
                },
                -- enable inlay hints for parameter names,
                inlayHints = {
                    parameterNames = {
                        enabled = "all"
                    }
                }
            }
        }

        -- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
        local init_options = {
            bundles = bundles,
            extendedClientCapabilities = extendedClientCapabilities
        }

        -- Function that will be ran once the language server is attached
        local on_attach = function(_, bufnr)
            -- Setup the java debug adapter of the JDTLS server
            require('jdtls.dap').setup_dap()

            -- Find the main method(s) of the application so the debug adapter can successfully start up the application
            -- Sometimes this will randomly fail if language server takes to long to startup for the project, if a ClassDefNotFoundException occurs when running
            -- the debug tool, attempt to run the debug tool while in the main class of the application, or restart the neovim instance
            -- Unfortunately I have not found an elegant way to ensure this works 100%
            require('jdtls.dap').setup_dap_main_class_configs()
            -- Enable jdtls commands to be used in Neovim
            require('jdtls.setup').add_commands()

            -- Refresh the codelens
            -- Code lens enables features such as code reference counts, implemenation counts, and more.
            vim.lsp.codelens.refresh()

            -- Setup a function that automatically runs every time a java file is saved to refresh the code lens
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.java" },
                callback = function()
                    local _, _ = pcall(vim.lsp.codelens.refresh)
                end
            })
        end

        -- Create the configuration table for the start or attach function
        local config = {
            cmd = cmd,
            root_dir = root_dir,
            settings = settings,
            capabilities = capabilities,
            init_options = init_options,
            on_attach = on_attach
        }

        -- Start the JDTLS server
        require('jdtls').start_or_attach(config)
    end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          setup_jdtls()
        end,
      })

      local servers = {
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
        ts_ls = {},
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
        angularls = {},
        intelephense = {},
        tailwindcss = {},
        jsonls = {
          schemas = require("schemastore").json.schemas(),
        },
        -- jdtls = {
        -- },
      }

      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        -- ensure_installed = vim.tbl_keys(servers),
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
}

return M
