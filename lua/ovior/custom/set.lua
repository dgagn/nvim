local M = {}

function M.setup()
  vim.opt.hlsearch = false
  vim.opt.incsearch = true

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.breakindent = true

  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  vim.opt.signcolumn = 'yes'

  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.undofile = true
  vim.opt.undolevels = 10000
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

  vim.opt.scrolloff = 8

  vim.opt.splitbelow = true
  vim.opt.splitright = true

  vim.opt.cursorline = true
  vim.opt.termguicolors = true

  vim.opt.updatetime = 250
  vim.opt.timeout = true
  vim.opt.timeoutlen = 300

  vim.o.completeopt = 'menuone,noselect'
end

return M