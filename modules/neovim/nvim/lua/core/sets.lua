vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.formatoptions:remove("cro")
vim.opt.clipboard:append("unnamedplus")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoread = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.listchars = { tab = ">-", space = "·" }
vim.opt.list = true

vim.opt.colorcolumn = "80,100"

vim.g.mapleader = " "

vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 20
