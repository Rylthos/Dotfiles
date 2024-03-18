local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>ts", builtin.treesitter, {})
vim.keymap.set("n", "<leader>tm", builtin.marks, {})

require("telescope").load_extension("themes")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["jk"] = actions.close,
				["<C-q>"] = actions.send_to_qflist,
			},
			n = {
				["jk"] = actions.close,
			},
		},
	},
	extensions = {
		template = {},
		themes = {
			enable_previewer = true,
			enable_live_preview = true,
		},
	},
	file_ignore_patterns = {
		"vendor",
	},
})

require("telescope").load_extension("template")
vim.keymap.set("n", "<leader>tT", require("telescope").extensions.template.template, {})
