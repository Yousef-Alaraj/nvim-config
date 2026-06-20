return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- The new API uses the top-level module
		require("nvim-treesitter").setup()

		-- The new way to ensure parsers are installed
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

		-- Your original (and correct) autocmd implementation
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
