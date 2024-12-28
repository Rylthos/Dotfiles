local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>pf", fzf.files, {})
vim.keymap.set("n", "<leader>ps", fzf.live_grep, {})
vim.keymap.set("n", "<leader>ts", fzf.treesitter, {})
vim.keymap.set("n", "gd", fzf.lsp_definitions, {})
vim.keymap.set("n", "gr", fzf.lsp_references, {})

fzf.setup {
	winopts = {
		previws = {
			default = "bat",
		},
	},
	keymap = {
		builtin = {
			true,
			["jk"] = "hide",
		},
	},
}
