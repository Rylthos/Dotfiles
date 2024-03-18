require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
	},
	renderer = {
		group_empty = true,
		special_files = { "CMakeFiles.txt", ".gitignore", "readme.md" },
		icons = {
			glyphs = {
				bookmark = "",
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	git = {
		ignore = false,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>tf", vim.cmd.NvimTreeFocus)
vim.keymap.set("n", "<leader>tr", vim.cmd.NvimTreeRefresh)
