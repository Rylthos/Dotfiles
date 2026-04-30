vim.pack.add {
  "https://github.com/echasnovski/mini.files.git"
}

require("mini.files").setup {

}

local minifiles_toggle = function()
  if not MiniFiles.close() then MiniFiles.open() end
end

vim.keymap.set("n", "<leader>pv", minifiles_toggle, {silent=true})
