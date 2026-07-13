return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- Using the correct top-level API
		require("nvim-treesitter").setup({

			-- Declaratively define your parsers
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

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering a buffer
			auto_install = true,

			-- Treesitter-based indentation
			indent = {
				enable = true,
			},

			-- AST-based syntax highlighting
			highlight = {
				enable = true,
			},
		})
	end,
}
