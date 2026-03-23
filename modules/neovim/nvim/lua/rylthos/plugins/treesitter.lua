return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/playground",
  },
  lazy = false,
  build = ":TSUpdate",
  config = function()
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
  end
}
