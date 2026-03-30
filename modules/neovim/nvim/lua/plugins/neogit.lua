vim.pack.add {
  "https://github.com/NeogitOrg/neogit.git",
  "https://github.com/nvim-lua/plenary.nvim.git",
  "https://github.com/sindrets/diffview.nvim.git",
}

local neogit = require("neogit")
vim.keymap.set("n", "<leader>gc", neogit.open, {})
