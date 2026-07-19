return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- 1. Install your desired parsers
		-- You can replace these with the languages you actually use
		require("nvim-treesitter").install({ "c", "javascript", "cpp", "lua", "html", "python", "css", "markdown" })

		-- 2. Enable Treesitter highlighting and folding via Neovim's native API
		-- The repository states this is required because the plugin no longer does it for you
		vim.api.nvim_create_autocmd("FileType", {
			-- You can specify exact filetypes here like { 'rust', 'javascript' }
			-- or use { '*' } to attempt it on all files
			pattern = {
				"c",
				"cpp",
				"python",
				"lua",
				"javascript",
				"html",
				"css",
				"markdown",
			},
			callback = function()
				-- Enable syntax highlighting
				vim.treesitter.start()

				-- Enable Treesitter-based folding
				-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				-- vim.wo[0][0].foldmethod = "expr"

				-- Enable Treesitter-based indentation (considered experimental by the repo)
				if vim.bo.filetype ~= "lua" then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
