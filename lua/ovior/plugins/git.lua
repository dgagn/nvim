return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    config = function()
      vim.keymap.set("n", "<leader>g", vim.cmd.Git, { desc = "Open git status" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<right>", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
      vim.keymap.set("n", "<left>", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })

      vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
      vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })
      vim.keymap.set("n", "gs", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage hunk" })
      -- vim.keymap.set("n", "gs", "<nop>", { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset buffer" })
      vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>gH", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage hunk" })
      vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
    end,
  },
}
