vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    vim.notify('Building blink.cmp', vim.log.levels.INFO)
    local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = ev.data.path }):wait()
    if obj.code == 0 then
      vim.notify('Building blink.cmp done', vim.log.levels.INFO)
    else
      vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
    end
  end
})

vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig.git",
  {
    src = "https://github.com/saghen/blink.cmp.git",
    version = vim.version.range("1.*"),
  },
  "https://github.com/kevinhwang91/nvim-ufo.git",
  "https://github.com/kevinhwang91/promise-async.git",
  "https://github.com/ray-x/lsp_signature.nvim.git",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
}

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
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca",  vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>K",  vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>dd",  vim.diagnostic.setqflist, opts)
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
  "ltex_plus",
  "lua_ls",
  "marksman",
  "nixd",
  "pyright",
  "rust_analyzer",
  "slangd",
  "texlab",
  "ts_ls",
}

vim.lsp.config("*", {
  capabilities=lsp_capabilities
})

vim.lsp.config("lua_ls", {
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
})

vim.lsp.config("glsl_analyzer", {
  capabilities = lsp_capabilities,
  on_attach = function(client, bufnr)
    if client.name == "glsl_analyzer" then
      client.cancel_request = function (client, request_id) end
    end
  end
})

vim.lsp.config("slangd", {
  capabilities = lsp_capabilities,
  settings = {
    slang = {
      inlayHints= {
        deducedTypes = true,
        parameterNames = true,
      },
    },
  },
})

vim.lsp.config("ltex_plus", {
  capabilities = lsp_capabilities,
  cmd = { "ltex-ls-plus" },
  on_attach = function()
    require('ltex_extra').setup {
      load_langs = { "en-GB" },
      init_check = true,
      path = vim.fn.expand('~') .. '/.local/share/ltex',
    }
  end,
  settings = {
    ltex = {
      language = "en-GB",
      enabled = { "latex", "tex", "gitcommit" },
      -- additionalRules = {
        -- 	enablePickyRules = true,
        -- },
      },
    },
    filetypes = { "bib", "tex", "gitcommit" },
    flags = { debounce_text_changes = 300 },
  })

  vim.lsp.enable(lsps)
