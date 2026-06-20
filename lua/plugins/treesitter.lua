return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"cpp",
				"python",
				"lua",
				"javascript",
				"html",
				"css",
				"markdown",
				"markdown_inline",
			},
			-- This replaces your autocmd hack
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			-- This handles the structural indentation automatically
			indent = { enable = true },
		})
	end,
}
