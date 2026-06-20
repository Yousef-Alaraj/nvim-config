return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		vim.keymap.set("n", "<leader>pf", require("telescope.builtin").find_files)
		vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files)
		vim.keymap.set("n", "<leader>ps", function()
			require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>en", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end)
	end,
}
