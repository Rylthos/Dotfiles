return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.4",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"andrew-george/telescope-themes",
			"killer29018/template.nvim",
		},
	},

	-- LSP
	"neovim/nvim-lspconfig",

	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",

	"ray-x/lsp_signature.nvim",

	"micangl/cmp-vimtex",

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
	},

	{
		"mg979/vim-visual-multi",
		branch = "master",
	},

	"karb94/neoscroll.nvim",

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

	"lervag/vimtex",

	"stevearc/vim-arduino",

	{
		"kylechui/nvim-surround",
		version = "*",
	},

	"xiyaowong/transparent.nvim",

	"ngtuonghy/live-server-nvim",

	-- Themes
	"folke/tokyonight.nvim",
	"EdenEast/nightfox.nvim",
	"Alexis12119/nightly.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	"comfysage/evergarden",
	"bluz71/vim-nightfly-colors",
}
