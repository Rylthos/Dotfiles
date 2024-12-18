local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>pf", fzf.files, {})
vim.keymap.set("n", "<leader>ps", fzf.live_grep, {})
vim.keymap.set("n", "<leader>ts", fzf.treesitter, {})

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
