vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter.git"
}

require'nvim-treesitter'.setup {
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    disable = {"latex", "vimdoc"},
    additional_vim_regex_highlighting = false,
  },
}
