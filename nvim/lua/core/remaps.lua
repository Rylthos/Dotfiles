vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>o", "o<Esc>k")
vim.keymap.set("n", "<leader>O", "O<Esc>j")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Y", "yy")

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- vim.keymap.set("n", "<leader>f", function()
--     vim.lsp.buf.format()
-- end)

vim.keymap.set("n", "<leader>co", ":copen<enter>", { silent = true })
vim.keymap.set("n", "<leader>cq", ":cclose<enter>", { silent = true })
vim.keymap.set("n", "<leader>cn", ":cnext<enter>", { silent = true })
vim.keymap.set("n", "<leader>cp", ":cprevious<enter>", { silent = true })

-- Replace what is under the cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><enter>")
vim.keymap.set("t", "jk", "<C-\\><C-n><enter>")
