return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      { "<leader>d", ":Trouble diagnostics<cr>", desc = "Show the diagnostic in a trouble dialog" },
    },
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "php", "astro", "javascriptreact", "typescriptreact", "mustache" },
  },
  {
    "echasnovski/mini.bufremove",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete the current buffer",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    opts = {},
    keys = {
      {
        "<leader>m",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Mark the file",
      },
      {
        "]1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
      },
      {
        "]2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
      },
      {
        "]3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
      },
      {
        "]4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
      },
      {
        "<c-e>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Open the harpoon quick menu",
      },
    },
  },
  {
    "phpactor/phpactor",
    ft = "php",
    build = function()
      local handle = io.open("composer --version")
      if not handle then
        print("Composer is not installed")
        return
      end
      local result = handle:read("*a")
      handle:close()

      if not string.match(result, "Composer version") then
        print("Composer is not installed")
        return
      end

      vim.cmd("!composer install --no-dev --optimize-autoloader")
    end,
    config = function()
      vim.keymap.set("n", "<leader>pa", "<cmd>PhpactorContextMenu<cr>", { desc = "The php actor context menu" })
      vim.keymap.set("n", "<leader>pn", "<cmd>PhpactorClassNew<cr>", { desc = "Create a new class" })
    end,
  },
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test the nearest" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test the file" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite --parallel<cr>", { desc = "Test the suite" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Test the last test" })
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { desc = "Visit test" })

      vim.cmd([[
        let test#strategy = 'harpoon'
      ]])
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- columns = {},
      columns = { "icon" },
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          return name == ".DS_Store" or name == "thumbs.db" or name == ".."
        end,
      },
    },
  },
  "tpope/vim-dadbod",
  "tpope/vim-dotenv",
  {
    "danymat/neogen",
    config = true,
    ft = "java",
  }
}
