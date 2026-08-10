vim.pack.add {'https://github.com/catppuccin/nvim'}

require('catppuccin').setup({
	flavour = "mocha",
	styles = {
		comments = {"italic"}
	},
})

vim.cmd.colorscheme 'catppuccin-nvim'
