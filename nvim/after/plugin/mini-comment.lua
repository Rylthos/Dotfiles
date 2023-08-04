local api = vim.api

api.nvim_create_autocmd("BufEnter", {
    pattern = "*.c, *.cpp, *.comp, *.vert, *.frag, *.h, *.hpp",
    command = "set commentstring=//%s"
})

require('mini.comment').setup {
    options = {
        ignore_blank_lines=true
    },

    mappings = {
        -- Normal / Visual
        -- Includes movements
        comment = 'gc',

        -- Current Line
        comment_line = '<leader>cc',
    }
}
