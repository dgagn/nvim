local function cursor_in_array_creation_expression()
  local ts_utils = require('nvim-treesitter.ts_utils')

  -- Get the current node
  local node = ts_utils.get_node_at_cursor()

  while node ~= nil do
    if node:type() == 'array_creation_expression' then
      return true
    end
    node = node:parent()
  end

  return false
end

local last_inserted_char = nil

local function insert_arrow()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local content = vim.api.nvim_get_current_line()
  local character_before = content:sub(col, col)
  if last_inserted_char ~= '-' and character_before == "-" and content:sub(col - 5) == "$this-" then
    vim.api.nvim_put({'>'}, 'c', true, true)
  end

  if last_inserted_char ~= '=' and character_before == "=" and cursor_in_array_creation_expression() then
    vim.api.nvim_put({'>'}, 'c', true, true)
  end

  last_inserted_char = character_before
end

local group = vim.api.nvim_create_augroup('TestGroup', { clear = true })
vim.api.nvim_create_autocmd('TextChangedI', {
  callback = insert_arrow,
  pattern = "*.php",
  group = group
})

