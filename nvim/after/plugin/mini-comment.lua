local api = vim.api

api.nvim_create_autocmd("BufEnter", {
    pattern = "*.c, *.cpp, *.comp, *.vert, *.frag, *.h, *.hpp, *.ino, *.glsl",
    command = "set commentstring=// %s"
})



require('mini.comment').setup {
    options = {
        custom_commentstring=function()
            local filetype = vim.api.nvim_buf_get_option(0, "filetype")
            if filetype == "cpp" or filetype == "glsl" or filetype == "c" then
                return "// %s"
            else
                return nil
            end
        end,
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
