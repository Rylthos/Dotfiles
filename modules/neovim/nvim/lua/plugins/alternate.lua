vim.pack.add {
  "http://github.com/Dkendal/nvim-alternate.git"
}

require("nvim-alternate").setup {
  rules = {
    { pattern = { "(.+).c(pp?)$", "%1.h%2" }},
    { pattern = { "(.+).h(pp?)$", "%1.c%2" }},
  },
}

vim.keymap.set('n', '<leader>fs', require('nvim-alternate').plug.edit)
