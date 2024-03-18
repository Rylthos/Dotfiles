vim.g.vimtex_compiler_latexmk = {
	options = {
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
		"-lualatex",
		"-shell-escape",
	},
}

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
