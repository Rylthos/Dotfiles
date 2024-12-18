return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = { 'saghen/blink.cmp' },
	},

	{
		'saghen/blink.cmp',
		version = 'v0.*',
		build = "cargo build --release",
	},

	"simrat39/rust-tools.nvim",

	"ray-x/lsp_signature.nvim",

	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	"stevearc/conform.nvim",

	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" }
	},

	{
		"nvim-treesitter/nvim-treesitter",
		main = "nvim-treesitter.configs",
	},

	"nvim-treesitter/playground",

	"mbbill/undotree",

	"nvim-tree/nvim-web-devicons",

	"norcalli/nvim-colorizer.lua",

	"sindrets/diffview.nvim",

	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		enabled = true,
	},

	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
	},

	"echasnovski/mini.comment",

	"echasnovski/mini.move",

	"echasnovski/mini.pairs",

	"derekwyatt/vim-fswitch",

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		version = "*",
		lazy = false,
	},

	"sheerun/vim-polyglot",

	"chentoast/marks.nvim",

	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	{
		"lervag/vimtex",
		lazy = false,
	},

	{
		"stevearc/vim-arduino",
		lazy = true,
	},

	{
		"kylechui/nvim-surround",
		version = "*",
	},

	"xiyaowong/transparent.nvim",

	{
		"ngtuonghy/live-server-nvim",
		lazy = true,
	},

	-- Themes
	"folke/tokyonight.nvim",
	"EdenEast/nightfox.nvim",
	"rebelot/kanagawa.nvim",
	"Alexis12119/nightly.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	"comfysage/evergarden",
	"aliqyan-21/darkvoid.nvim",
	"bluz71/vim-nightfly-colors",
}
