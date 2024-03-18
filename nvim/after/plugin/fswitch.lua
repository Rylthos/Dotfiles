vim.keymap.set("n", "<leader>fs", vim.cmd.FSHere)

vim.cmd([[
    au! BufEnter *.cpp let b:fswitchdst = 'hpp,h'
]])
