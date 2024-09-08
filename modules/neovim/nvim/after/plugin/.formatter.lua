--[[
local util = require "formatter.util"

c_cpp_Function = function()
    return {
        exe = "clang-format",
        args = {
            "-i",
            "--style=file",
            util.escape_path(util.get_current_buffer_file_path())
        }
    }
end

require("formatter").setup {
    logging = true,

    log_level = vim.log.levels.WARN,

    filetype = {
        cpp = { c_cpp_Function },
        c = { c_cpp_Function },

        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
        group = "__formatter__",
        command = ":FormatWriteLock"

})

-- Auto reload file
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
        group = "__formatter__",
        command = "if mode() != 'c' | checktime | endif",
        pattern = { "*" },
})

vim.keymap.set("n", "<leader>F", ":FormatWriteLock<CR>", { silent = true })
--]]
