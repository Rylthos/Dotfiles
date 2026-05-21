vim.pack.add {
  "https://github.com/rgroli/other.nvim.git",
}

require("other-nvim").setup {
  mappings = {
    "c"
  },
}

vim.keymap.set('n', '<leader>fs', ":Other<CR>")
