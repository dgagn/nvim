local M = {}

function M.setup()
  vim.opt.hlsearch = false
  vim.opt.incsearch = true

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.breakindent = true

  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  vim.opt.smartindent = true

  vim.opt.wrap = false

  vim.opt.signcolumn = 'yes'
  -- vim.opt.guicursor = ""

  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.undofile = true
  vim.opt.undolevels = 10000
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

  vim.g.loaded_matchparen = 1
  vim.opt.showmatch = true

  vim.opt.belloff = "all"
  vim.opt.tabstop = 4

  vim.opt.scrolloff = 8
  vim.opt.sidescrolloff = 8

  vim.opt.confirm = true

  vim.opt.splitbelow = true
  vim.opt.splitright = true

  vim.opt.cursorline = true

  vim.opt.updatetime = 250
  vim.opt.timeout = true
  vim.opt.timeoutlen = 300

  vim.o.completeopt = 'menuone,noselect'

  vim.opt.backspace = 'indent,eol,start'

  vim.opt.autoread = true

  vim.opt.colorcolumn = "80"

  vim.g.skip_ts_contextt_commentstring_module = true

  vim.diagnostic.config({
    virtual_text = true,
    float = {
      source = true
    }
  })
end

return M
