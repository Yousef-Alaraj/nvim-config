return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		-- 1. Explicitly install the languages for your stack
		require("nvim-treesitter").install({
			"c",
			"cpp",
			"python",
			"lua",
			"javascript",
			"html",
			"css",
			"markdown",
			"markdown_inline",
		})

		-- 2. THE NEW MAGIC SWITCH
		-- Hook into native Neovim to turn on the AST engine for Dracula
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				-- Turn on structural highlighting
				pcall(vim.treesitter.start)
				-- Turn on structural indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
