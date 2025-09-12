vim.g.vimtex_compiler_latexmk = {
	options = {
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
		"-lualatex",
		"-shell-escape",
		"-output-directory='build'",
	},
}

vim.g.vimtex_matchparen_enabled = 0
vim.g.vimtex_indent_enabled = 0
vim.g.vimtex_indent_align = 0
vim.g.vimtex_indent_on_ampersands = 0
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull" }

local vim_leader = ","
vim.keymap.set("n", vim_leader .. "ce", "<plug>(vimtex-env-surround-line)")
vim.keymap.set("n", vim_leader .. "ce", "<Plug>(vimtex-env-surround-line)")
vim.keymap.set("v", vim_leader .. "ce", "<Plug>(vimtex-env-surround-visual)")

vim.keymap.set("n", vim_leader .. "cf", "<Plug>(vimtex-compile)")

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

-- vim.g.vimtex_compiler_generic = { "command": "lualatex --shell-escape" }

-- vim.cmd [[
--
--     nnoremap ,ce <Plug>(vimtex-env-surround-line)
--     vnoremap ,ce <Plug>(vimtex-env-surround-visual)
--
--     nnoremap ,cf <Plug>(vimtex-compile)
--
--     nnoremap ,cc <Plug>(vimtex-cmd-create)
--     vnoremap ,cc <Plug>(vimtex-cmd-create)
--
--     nnoremap ,cd <Plug>(vimtex-cmd-delete)
--     vnoremap ,cd <Plug>(vimtex-cmd-delete)
--
--     nnoremap ,tb <Plug>(vimtex-delim-toggle-modifier)
--     vnoremap ,tb <Plug>(vimtex-delim-toggle-modifier)
-- ]]
