vim.pack.add {
  {
    src = "https://github.com/catppuccin/nvim.git",
    name = "catppuccin",
  },
}

vim.cmd([[colorscheme catppuccin]])

require("catppuccin").setup{
  flavour = "macchiato",
}
