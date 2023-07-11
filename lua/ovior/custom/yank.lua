local M = {}

M.setup = function()
  -- I prefer to have yanked text highlighted.
  local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = yank_group,
    pattern = "*",
  })
end

return M

