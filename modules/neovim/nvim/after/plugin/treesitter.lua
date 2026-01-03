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
