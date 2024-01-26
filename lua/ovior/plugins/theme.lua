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
    branch = "add-border",
    opts = {
      scope = "line",
    },
  },
}
