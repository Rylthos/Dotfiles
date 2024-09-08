local lspconfig = require('lspconfig')
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
		["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-space>"] = cmp.mapping.confirm({ select = true }),
	}),
	completion = {
		completopt = 'menu,menuone,noinsert',
	},
	sources = cmp.config.sources {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' }
	},
	view = {
		entries = { name = 'custom', selection_order = 'near_cursor' }
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
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

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
lsp_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}

local default_setup = function(server)
	require("lspconfig")[server].setup({
		capabilities = lsp_capabilities
	})
end

lspconfig.clangd.setup{}
default_setup("clangd")

lspconfig.texlab.setup{}
default_setup("texlab")

lspconfig.cmake.setup{}
default_setup("cmake")

lspconfig.jdtls.setup{}
default_setup("jdtls")

lspconfig.tsserver.setup{}
default_setup("tsserver")

lspconfig.cssls.setup{}
default_setup("cssls")

vim.diagnostic.config({ virtual_text = false })
require("lsp_lines").setup()
vim.keymap.set("n", "<leader>ll", require("lsp_lines").toggle)

require'ufo'.setup{

}
