vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

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
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "html", "css", "json" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end,
})

-- Perfect Soft-Wrapping for Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.wrap = true -- Turn on visual wrapping
		vim.opt_local.linebreak = true -- Bend the line at spaces, never chop a word in half
		vim.opt_local.breakindent = true -- If a bullet point wraps, indent the next line to match
	end,
})
