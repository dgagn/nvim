local map = function(mode, keybind, fn, desc)
  vim.keymap.set(mode, keybind, fn, { desc = desc })
end

map('n', '<leader>ff', require('telescope.builtin').find_files, 'Find files')
map('n', '<leader>fb', require('telescope.builtin').buffers, 'Find in buffers')
map('n', '<leader>fg', require('telescope.builtin').live_grep, 'Find live grep')
map('n', '<leader>fw', require('telescope.builtin').grep_string, 'Find current word')
map('n', '<leader>fd', require('telescope.builtin').diagnostics, 'Find diagnostics')
map('n', '<leader>fh', require('telescope.builtin').help_tags, 'Find help tags')

map('n', '<leader>?', require('telescope.builtin').oldfiles, 'Find recently opened files')
map('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, 'Find recently opened files')
