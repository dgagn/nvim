local M = {}

local function get_class_start_end(col)
  local content = vim.api.nvim_get_current_line()
  local class_start, class_end = nil, nil

  local current_character = content:sub(col + 1, col + 1)
  if current_character == " " then
    return
  end

  for i = col, 1, -1 do
    local character = content:sub(i, i)
    if character == "'" or character == " " or character == '"' then
      class_start = i
      break
    end
  end

  for i = col + 1, #content do
    local character = content:sub(i, i)
    if character == "'" or character == " " or character == '"' then
      class_end = i
      break
    end
  end

  if class_end ~= nil then
    class_end = class_end - 1
  end

  return class_start, class_end
end

function M.select_inner_class_name()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local class_start, class_end = get_class_start_end(col)

  if class_start and class_end then
    vim.api.nvim_win_set_cursor(0, { line, class_start })
    vim.cmd('normal! v')
    vim.api.nvim_win_set_cursor(0, { line, class_end - 1 })
  end
end

function M.select_around_class_name()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local content = vim.api.nvim_get_current_line()
  local class_start, class_end = get_class_start_end(col)

  if class_start and class_end then
    local character_before = content:sub(class_start, class_start)
    local character_after = content:sub(class_end + 1, class_end + 1)

    local whitespace = character_before == " "
    if whitespace then
      class_start = class_start - 1
    elseif character_after == " " then
      class_end = class_end + 1
    end

    vim.api.nvim_win_set_cursor(0, { line, class_start })
    vim.cmd('normal! v')
    vim.api.nvim_win_set_cursor(0, { line, class_end - 1 })
  end
end

function M.setup()
  vim.api.nvim_set_keymap('o', 'ic', ':<C-U>lua require("ovior.custom.cobj").select_inner_class_name()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('o', 'ac', ':<C-U>lua require("ovior.custom.cobj").select_around_class_name()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', 'ic', ':<C-U>lua require("ovior.custom.cobj").select_inner_class_name()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', 'ac', ':<C-U>lua require("ovior.custom.cobj").select_around_class_name()<CR>', { noremap = true, silent = true })
end

return M
