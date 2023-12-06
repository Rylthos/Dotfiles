vim.cmd [[
    let g:vimtex_compiler_method="lualatex"

    nnoremap ,ce <Plug>(vimtex-env-surround-line)
    vnoremap ,ce <Plug>(vimtex-env-surround-visual)
    nnoremap ,cf <Plug>(vimtex-compile)

    nnoremap ,cc <Plug>(vimtex-cmd-create)
    vnoremap ,cc <Plug>(vimtex-cmd-create)
]]
