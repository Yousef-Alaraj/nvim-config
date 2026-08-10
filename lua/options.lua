-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation (4 spaces default)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Wrapping
vim.opt.wrap = false

-- Persistent Undo & Backups (Excellent for CP)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search (Set to true so the <Esc> keymap in keymaps.lua actually has something to clear)
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Quality of Life
vim.opt.clipboard = "unnamedplus" -- Synced with macOS
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- UI
vim.opt.colorcolumn = "80"
vim.opt.splitbelow = true
vim.opt.splitright = true
