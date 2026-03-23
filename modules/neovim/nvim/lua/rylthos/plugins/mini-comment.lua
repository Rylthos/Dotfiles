return {
  "echasnovski/mini.comment",
  config = function()
    require('mini.comment').setup {
      options = {
        custom_commentstring=function()
          local filetype = vim.api.nvim_buf_get_option(0, "filetype")
          local slash_filetypes = {'cpp', 'c', 'glsl'}

          for index, value in ipairs(slash_filetypes) do
            if filetype == value then
              return "// %s"
            end
          end

          return nil
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
  end,
}
