local M = {}

local map = vim.keymap.set

function M.setup()
  map("n", "s", "<nop>", { silent = true })
  map("n", "<c-b>", "<nop>", { silent = true })
  map("i", "<c-b>", "<nop>", { silent = true })
  map({ "n", "v" }, "<space>", "<nop>", { silent = true })

  map("n", "<leader>;", "maA;<esc>`a", { desc = "Add a semicolon at the end of the line" })
  map("n", "<leader>,", "maA,<esc>`a", { desc = "Add a comma at the end of the line" })

  map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  map("n", "<leader>q", ":q<cr>", { desc = "Quit the window" })
  map("n", "q:", ":q") -- fuging anoying
  map("n", "<space>s", ":w<cr>", { desc = "Save the file" })

  map("n", "<C-d>", "<C-d>zz")
  map("n", "<C-u>", "<C-u>zz")
  map("i", "<C-u>", "<nop>")

  map("x", "<leader>p", '"_dP', { desc = "Paste over and delete to void" })
  map("n", "<leader>p", '"+p', { desc = "Paste system clipboard" })

  map("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
  map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

  map("n", "n", "nzzzv")
  map("n", "N", "Nzzzv")

  map("v", "<", "<gv")
  map("v", ">", ">gv")

  map("i", "<M-Right>", "<C-o>w")
  map("i", "<M-Left>", "<C-o>b")
  map("i", "<S-Tab>", "<C-d>")

  map("i", "<c-i>", "<c-o>I", { desc = "Goto the start of the line" })
  map("n", "<c-i>", "I", { desc = "Goto the start of the line" })

  map("v", "u", "<nop>")

  map("v", "O", "o<Esc>a", { silent = true })

  -- c-;
  -- map("i", "<f25>", "<esc>A,")
  -- -- c-,
  -- map("i", "<f26>", "<esc>A;")

  -- c-;
  -- map("n", "<f25>", "<esc>A,")
  -- -- c-,
  -- map("n", "<f26>", "<esc>A;")

  map("n", "<leader>O", "O<Esc>j", { desc = "Add an empty line above" })
  map("n", "<leader>o", "o<Esc>k")
  map("t", "<c-x>", "<c-\\><c-n>")

  map("n", "<leader>vs", "<cmd>vsp<cr>")
  map("n", "<leader>hs", "<cmd>sp<cr>")
  map("n", "<leader>vt", "<cmd>vsp<cr><cmd>terminal<cr>")
  map("n", "<leader>ht", "<cmd>sp<cr><cmd>terminal<cr>")

  map("n", "gn", "<cmd>:bnext<cr>")
  map("n", "gp", "<cmd>:bprev<cr>")
  map("n", "g$", "<cmd>:blast<cr>")
  map("n", "g^", "<cmd>:bfirst<cr>")

  map("i", "<c-f>", "<Plug>luasnip-jump-next", { silent = true })
  map("s", "<c-f>", "<Plug>luasnip-jump-next", { silent = true })

  map("n", "<c-c>", "<esc>")

  map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
end

return M
