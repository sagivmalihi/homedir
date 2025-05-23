vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true

vim.opt.wrap = false

vim.opt.mouse = "a"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.selection = "inclusive"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.opt.keymodel = "startsel,stopsel"

vim.opt.ignorecase = true       -- Ignore case letters when search
vim.opt.smartcase = true        -- Ignore lowercase for the whole pattern
