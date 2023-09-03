local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

function M.setup()
  local lazy = require('lazy')
  local yank = require('ovior.custom.yank')
  local set = require('ovior.custom.set')
  local remap = require('ovior.custom.remap')
  local aucmd = require('ovior.custom.autocmd')

  yank.setup()
  set.setup()
  remap.setup()
  aucmd.setup()
  lazy.setup({
    -- import my plugins in the plugins folder
    spec = {
      { import = 'ovior.plugins' },
    },
    install = {
      colorscheme = { 'rose-pine' }
    },
    -- please don't autoupdate plugins
    checker = { enable = false },
  })
end

return M
