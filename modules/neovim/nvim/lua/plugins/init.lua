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
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
    },

    {
        'saghen/blink.cmp',
        version = 'v0.*',
        build = "cargo build --release",
    },

    "simrat39/rust-tools.nvim",

    "ray-x/lsp_signature.nvim",

    "ThePrimeagen/vim-be-good",

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

    "tpope/vim-sleuth",

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

    -- "echasnovski/mini.pairs",

    "derekwyatt/vim-fswitch",

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },

    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = { },
    },

    "kalvinpearce/ShaderHighlight",

    "chentoast/marks.nvim",

    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- {
    -- 	"christoomey/vim-tmux-navigator",
    -- 	lazy = false,
    -- },

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
    "windwp/nvim-ts-autotag",
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    "xiyaowong/transparent.nvim",

    {
        "ngtuonghy/live-server-nvim",
        lazy = true,
    },

    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",

        enabled = true,  -- if you want to enable the plugin
        message_template = " <summary> • <date> • <author>", -- template for the blame message, check the Message template section for more options
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        virtual_text_column = 1,
    },

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "ibhagwan/fzf-lua",              -- optional
        },
    },

    -- Themes
    {
        "scottmckendry/cyberdream.nvim",
        lazy=false,
        priority=1000,
        config = function()
            vim.cmd("colorscheme cyberdream")
        end,
        opts = {
            transparent = true,
            saturation = 0.8,
        }
    },

    --[[
    {
        "akinsho/horizon.nvim",
        opts = {
            plugins =  {
                cmp = true,
                neo_tree = true,
                gitsigns = true,
            },
        },
        config = function()
            vim.cmd("colorscheme horizon")
        end
    },
    --]]
    "folke/tokyonight.nvim",
    "EdenEast/nightfox.nvim",
    --[[
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd("colorscheme kanagawa-wave")
        end
    },

    {
        "ficcdaf/ashen.nvim",
        lazy =false,
        priority=1000,
        config = function()
            vim.cmd("colorscheme ashen")
        end
    },
    --]]
}
