return {
  -- manages the indents
  -- {
  --   "szw/vim-maximizer",
  --   keys = {
  --     { "<leader>m", "<cmd>MaximizerToggle<CR>" },
  --   },
  -- },
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
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Open git status" },
    },
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
    "mizlan/iswap.nvim",
    cmd = { "ISwapWith", "ISwapNodeWith" },
    opts = {
      grey = "disable",
    },
    keys = {
      { "<leader>aa", vim.cmd.ISwapWith,     desc = "Arrange the argument orders" },
      { "<leader>an", vim.cmd.ISwapNodeWith, desc = "Arrange the node orders" },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    opts = {
      start_in_insert = false,
    },
    keys = {
      { "<F1>", "<cmd>ToggleTerm<cr>i",           mode = "n" },
      { "<F1>", "<esc><cmd>ToggleTerm<cr>",       mode = "i" },
      { "<F1>", "<C-\\><C-n><cmd>ToggleTerm<cr>", mode = "t" },
    },
  },
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev --optimize-autoloader",
    config = function()
      vim.keymap.set("n", "<leader>pa", "<cmd>PhpactorContextMenu<cr>", { desc = "The php actor context menu" })
    end,
  },
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test the nearest" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test the file" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>", { desc = "Test the suite" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Test the last test" })
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { desc = "Visit test" })

      vim.cmd([[
        let test#strategy = 'neovim'
      ]])
    end,
  },
  {
    "ggandor/flit.nvim",
    enabled = true,
    keys = function()
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    dependencies = {
      "ggandor/leap.nvim",
    },
    opts = {
      labeled_modes = "nx",
      multiline = false,
    },
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
      vim.api.nvim_set_hl(0, "LeapLabelPrimary", { bold = true, fg = "grey" })
    end,
  },
  {
    "tpope/vim-projectionist",
    dependencies = "tpope/vim-dispatch",
    config = function()
      require("ovior.configs.projectionist")
    end,
  },
  "vimwiki/vimwiki",
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
}
