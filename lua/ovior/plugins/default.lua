return {
  -- Detect tabstop and shiftwidth auto
  "tpope/vim-sleuth",
  -- Instead of repeating last change, repeat last action
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- goto last place in the buffer you were
  "farmergreg/vim-lastplace",
  -- format some trailing comma with gS
  {
    "AndrewRadev/splitjoin.vim",
    config = function()
      vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
      vim.g.splitjoin_trailing_comma = 1
      vim.g.splitjoin_php_method_chain_full = 1
    end,
  },
  -- surround helpers
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "tpope/vim-projectionist",
    dependencies = "tpope/vim-dispatch",
    config = function()
      require("ovior.configs.projectionist")
    end,
  },
  -- set the root directory of the repo
  {
    "airblade/vim-rooter",
    init = function()
      vim.g.rooter_manual_only = 1
      vim.g.rooter_patterns = { ".git", ".gitignore", ".gitmodules", "Makefile", "package.json", "Cargo.toml" }
    end,
  },
  -- paste with proper indentation
  {
    "sickill/vim-pasta",
    config = function()
      vim.g.pasta_disabled_filetypes = { "gitcommit", "gitrebase", "svn", "fugitive", "fugitiveblame", "qf", "help" }
    end,
  },
}
