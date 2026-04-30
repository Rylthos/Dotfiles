vim.pack.add {
  "https://github.com/fasterius/simple-zoom.nvim.git",
}

require("simple-zoom").setup {
}

vim.keymap.set('n', "<leader>z", require("simple-zoom").toggle_zoom)
