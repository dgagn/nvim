return {
  -- is there really something better than rose-pine?
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme('rose-pine')
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff' })
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {}
  },
  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {
      scope = 'line',
      update_event = { 'DiagnosticChanged', 'BufEnter' }
    },
  }
}
