vim.pack.add {
  {
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim.git",
    version = vim.version.range("3"),
  },
  "https://github.com/nvim-lua/plenary.nvim.git",
  "https://github.com/nvim-tree/nvim-web-devicons.git",
  "https://github.com/MunifTanjim/nui.nvim.git",
}

require("neo-tree").setup({})
vim.keymap.set("n", "<leader>pv", ":Neotree toggle<cr>", {silent=true})
