vim.keymap.set("n", "<leader>fs", vim.cmd.FSHere)

vim.cmd([[
    au! BufEnter *.cpp let b:fswitchdst = 'hpp,h'
    au! BufEnter *.ml let b:fswitchdst = 'mli' | let b:fswitchlocs='rel:../bin'
    au! BufEnter *.mli let b:fswitchdst = 'ml' | let b:fswitchlocs='rel:../bin'
]])
