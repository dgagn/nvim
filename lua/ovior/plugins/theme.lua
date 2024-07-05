return {
  -- is there really something better than rose-pine?
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        disable_float_background = true,
        highlight_groups = {
          CursorLine = { bg = "none" },
          Normal = { bg = "none" },
          NormalFloat = { bg = "none" },
          CursorLineNr = { fg = "#ffffff" },
        },
      })
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
      scope = "line",
      placement = "top",
      update_event = {
        "BufReadPost",
        "DiagnosticChanged",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local p = require("rose-pine.palette")

      local theme = {
        normal = {
          a = { bg = "none", fg = p.rose, gui = "bold" },
          b = { bg = "none", fg = p.rose },
          c = { bg = "none", fg = p.text },
        },
        insert = {
          a = { bg = "none", fg = p.foam, gui = "bold" },
          b = { bg = "none", fg = p.foam },
          c = { bg = "none", fg = p.text },
        },
        visual = {
          a = { bg = "none", fg = p.iris, gui = "bold" },
          b = { bg = "none", fg = p.iris },
          c = { bg = "none", fg = p.text },
        },
        replace = {
          a = { bg = "none", fg = p.pine, gui = "bold" },
          b = { bg = "none", fg = p.pine },
          c = { bg = "none", fg = p.text },
        },
        command = {
          a = { bg = "none", fg = p.love, gui = "bold" },
          b = { bg = "none", fg = p.love },
          c = { bg = "none", fg = p.text },
        },
        inactive = {
          a = { bg = "none", fg = p.base, gui = "bold" },
          b = { bg = "none", fg = p.muted },
          c = { bg = "none", fg = p.muted },
        },
      }
      return {
        options = {
          theme = theme,
          component_separators = "-",
          section_separators = "",
          icons_enabled = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "buffers",
            }
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
    "lukas-reineke/indent-blankline.nvim",
    main = 'ibl',
    opts = {
      scope = { enabled = false }
    }
  }
}
