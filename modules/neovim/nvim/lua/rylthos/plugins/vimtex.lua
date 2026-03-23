return {
  "lervag/vimtex",
  dependencies = {
    "barreiroleo/ltex_extra.nvim",
  },
  lazy = false,
  config = function()
    vim.g.vimtex_compiler_latexmk = {
      out_dir = "build",
      options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-shell-escape",
      },
    }

    vim.g.vimtex_quickfix_mode=0
    vim.g.vimtex_quickfix_open_on_warning=0

    vim.g.vimtex_matchparen_enabled = 0
    vim.g.vimtex_indent_enabled = 0
    vim.g.vimtex_indent_align = 0
    vim.g.vimtex_indent_on_ampersands = 0
    vim.g.vimtex_view_method = "zathura"

    local vim_leader = ","
    vim.keymap.set("n", vim_leader .. "ce", "<plug>(vimtex-env-surround-line)")
    vim.keymap.set("v", vim_leader .. "ce", "<Plug>(vimtex-env-surround-visual)")

    vim.keymap.set("n", vim_leader .. "cf", "<Plug>(vimtex-compile)")
    vim.keymap.set("n", vim_leader .. "css", "<Plug>(vimtex-compile-ss)")

    vim.keymap.set("n", vim_leader .. "cc", "<Plug>(vimtex-cmd-create)")
    vim.keymap.set("v", vim_leader .. "cc", "<Plug>(vimtex-cmd-create)")

    vim.keymap.set("n", vim_leader .. "dc", "<Plug>(vimtex-cmd-delete)")
    vim.keymap.set("v", vim_leader .. "dc", "<Plug>(vimtex-cmd-delete)")

    vim.keymap.set("n", vim_leader .. "de", "<Plug>(vimtex-env-delete)")
    vim.keymap.set("v", vim_leader .. "de", "<Plug>(vimtex-env-delete)")

    vim.keymap.set("n", vim_leader .. "tb", "<Plug>(vimtex-delim-toggle-modifier)")
    vim.keymap.set("v", vim_leader .. "tb", "<Plug>(vimtex-delim-toggle-modifier)")

    vim.keymap.set("n", vim_leader .. "tsc", "<Plug>(vimtex-cmd-toggle-star)")
    vim.keymap.set("n", vim_leader .. "tse", "<Plug>(vimtex-env-toggle-star)")
  end
}
