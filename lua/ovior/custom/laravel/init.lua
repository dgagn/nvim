local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local Terminal = require("toggleterm.terminal").Terminal

local M = {}

M.open = function(opts)
  opts = opts or {}
  pickers
      .new(require("telescope.themes").get_dropdown({}), {
        prompt_title = "Action name",
        finder = finders.new_table({
          results = { "Create Controller", "Create Resource" },
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local t = Terminal:new({
              cmd = "php artisan make:controller",
              hidden = true,
              direction = "float",
            })
            t:toggle()
          end)
          return true
        end,
      })
      :find()
end

return M
