return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<c-n>", "<cmd>NeoTreeRevealToggle<cr>", desc = "Neotree toggle the tree" }
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            'node_modules',
          }
        }
      },
      window = {
        mappings = {
          ['<space>'] = 'none'
        }
      }
    }
  }
}
