local M = {}

local map = vim.keymap.set

function M.setup()
  map({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

  map("n", "<leader>q", ":q<cr>", { desc = "Quit the window" })
  map("n", "<leader>s", ":w<cr>", { desc = "Save the file" })

  map("n", "<C-d>", "<C-d>zz")
  map("n", "<C-u>", "<C-u>zz")

  map("x", "<leader>p", "\"_dP", { desc = "Paste over and delete to void" })

  map("n", "<leader>y", "\"+y", { desc = "Copy to system clipboard" })
  map("v", "<leader>y", "\"+y", { desc = "Copy to system clipboard" })

  map("n", "n", "nzzzv")
  map("n", "N", "Nzzzv")

  map('i', '<M-Right>', '<C-o>w')
  map('i', '<M-Left>', '<C-o>b')
  map("i", "<S-Tab>", "<C-d>")

  map('i', '<c-a>', '<c-o>$', {desc = 'Goto the end of the line'})

  map("n", "<leader>O", "O<Esc>j", { desc = 'Add an empty line above' })
  map("n", "<leader>o", "o<Esc>k")
  map('t', '<c-x>', '<c-\\><c-n>')

  map('n', '<leader>vs', '<cmd>vsp<cr>')
  map('n', '<leader>hs', '<cmd>sp<cr>')
  map('n', '<leader>vt', '<cmd>vsp<cr><cmd>terminal<cr>')
  map('n', '<leader>ht', '<cmd>sp<cr><cmd>terminal<cr>')
end

return M
