return {
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", ":UndotreeToggle<cr>", desc = "Open the undotree" },
    }
  },
  "tpope/vim-sleuth",
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      { "<leader>tr", ":TroubleToggle<cr>", desc = "Show the diagnostic in a trouble dialog" },
    },
  },
  {
    "monkoose/matchparen.nvim",
    opts = {},
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "astro", "javascriptreact", "typescriptreact" },
  },
  {
    "AndrewRadev/splitjoin.vim",
    config = function()
      vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
      vim.g.splitjoin_trailing_comma = 1
      vim.g.splitjoin_php_method_chain_full = 1
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", ":TmuxNavigateLeft<CR>",  desc = "Move to the left tmux pane" },
      { "<C-j>", ":TmuxNavigateDown<CR>",  desc = "Move to the down tmux pane" },
      { "<C-k>", ":TmuxNavigateUp<CR>",    desc = "Move to the up tmux pane" },
      { "<C-l>", ":TmuxNavigateRight<CR>", desc = "Move to the right tmux pane" },
    },
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    config = function()
      vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Open git status" })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      triggers = { "<leader>", "g", "<c-w>" },
    },
  },
  {
    "echasnovski/mini.bufremove",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete the current buffer",
      },
    },
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  "farmergreg/vim-lastplace",
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")

      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.outer", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }, {}),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }, {}),
          a = ai.gen_spec.treesitter({
            i = "@parameter.inner",
            a = "@parameter.outer",
          }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
    },
    keys = {
      {
        "<leader>cr",
        function()
          require("spectre").open()
        end,
        desc = "Show spectre",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    opts = {},
    keys = {
      {
        "<leader>m",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Mark the file",
      },
      {
        "]1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
      },
      {
        "]2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
      },
      {
        "]3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
      },
      {
        "]4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
      },
      {
        "<F3>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Open the harpoon quick menu",
      },
    },
  },
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev --optimize-autoloader",
    config = function()
      vim.keymap.set("n", "<leader>pa", "<cmd>PhpactorContextMenu<cr>", { desc = "The php actor context menu" })
      vim.keymap.set("n", "<leader>pn", "<cmd>PhpactorClassNew<cr>", { desc = "Create a new class" })
    end,
  },
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test the nearest" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test the file" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite --parallel<cr>", { desc = "Test the suite" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Test the last test" })
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { desc = "Visit test" })

      vim.cmd([[
        let test#strategy = 'neovim'
      ]])
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      columns = {},
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          return name == ".DS_Store" or name == "thumbs.db" or name == ".."
        end,
      },
    },
  },
  {
    "tpope/vim-projectionist",
    dependencies = "tpope/vim-dispatch",
    config = function()
      require("ovior.configs.projectionist")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local p = require("rose-pine.palette")

      local theme = {
        normal = {
          a = { bg = p.rose, fg = p.base, gui = "bold" },
          b = { bg = p.overlay, fg = p.rose },
          c = { bg = "none", fg = p.text },
        },
        insert = {
          a = { bg = p.foam, fg = p.base, gui = "bold" },
          b = { bg = p.overlay, fg = p.foam },
          c = { bg = "none", fg = p.text },
        },
        visual = {
          a = { bg = p.iris, fg = p.base, gui = "bold" },
          b = { bg = p.overlay, fg = p.iris },
          c = { bg = "none", fg = p.text },
        },
        replace = {
          a = { bg = p.pine, fg = p.base, gui = "bold" },
          b = { bg = p.overlay, fg = p.pine },
          c = { bg = "none", fg = p.text },
        },
        command = {
          a = { bg = p.love, fg = p.base, gui = "bold" },
          b = { bg = p.overlay, fg = p.love },
          c = { bg = "none", fg = p.text },
        },
        inactive = {
          a = { bg = p.base, fg = p.muted, gui = "bold" },
          b = { bg = p.base, fg = p.muted },
          c = { bg = "none", fg = p.muted },
        },
      }
      return {
        options = {
          theme = theme,
          component_separators = "|",
          section_separators = "",
          icons_enabled = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "buffers",
            },
          },
          lualine_c = {
            { "filename", path = 1 },
            "branch",
          },
          lualine_x = {
            "filetype",
          },
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<right>", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
      vim.keymap.set("n", "<left>", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })

      vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
      vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })
      vim.keymap.set("n", "gs", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset buffer" })
      vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>gH", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage hunk" })
      vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
    end,
  },
  {
    "airblade/vim-rooter",
    init = function()
      vim.g.rooter_manual_only = 1
      vim.g.rooter_patterns = { ".git", ".gitignore", ".gitmodules", "Makefile", "package.json", "Cargo.toml" }
    end,
    config = function()
      vim.cmd("Rooter")
    end,
  },
  {
    "sickill/vim-pasta",
    config = function()
      vim.g.pasta_disabled_filetypes = { "gitcommit", "gitrebase", "svn", "fugitive", "fugitiveblame", "qf", "help" }
    end,
  },
  "tpope/vim-eunuch",
}
