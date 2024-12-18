local lspconfig = require('lspconfig')
local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
lsp_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}

require("blink.cmp").setup {
	keymap = { preset = 'super-tab' },

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	signature = { enabled = true },
}

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
	end
})

require'lsp_signature'.setup({
	bind = true,
	handler_opts = {
		border = "rounded"
	},

	floating_window = true,
	wrap = true,
	max_height = 12,
	max_width = 80,

	hint_enable = false,
})

vim.keymap.set('n', "<leader>ls", function() require'lsp_signature'.toggle_float_win() end, { silent = true, noremap = true})

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.diagnostic.config({ virtual_text = false })
require("lsp_lines").setup()

vim.keymap.set("n", "<leader>ll", require("lsp_lines").toggle)

require'ufo'.setup{ }

local lsps = {
	"clangd",
	"cmake",
	"cssls",
	"glsl_analyzer",
	"jdtls",
	"rust_analyzer",
	"texlab",
	"ts_ls",
}

for _, v in ipairs(lsps) do
	lspconfig[v].setup {
		capabilities = lsp_capabilities
	}
end

lspconfig.lua_ls.setup {
	capabilities = lsp_capabilities,
	on_init = function(client)
		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					version = 'LuaJIT'
				},
				workspace = {
					checkThirdPart = false,
					library = {
						vim.env.VIMRUNTIME
					}
				}
			})
	end,

	settings = {
		Lua = {}
	}
}
