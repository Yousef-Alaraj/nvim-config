return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
		vim.keymap.set("n", "<leader>a", function()
			require("harpoon"):list():add()
		end, { desc = "Harpoon Add File" })
		vim.keymap.set("n", "<C-e>", function()
			require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
		end, { desc = "Harpoon Quick Menu" })
		vim.keymap.set("n", "<C-h>", function()
			require("harpoon"):list():select(1)
		end, { desc = "Harpoon Select 1" })
		vim.keymap.set("n", "<C-j>", function()
			require("harpoon"):list():select(2)
		end, { desc = "Harpoon Select 2" })
		vim.keymap.set("n", "<C-k>", function()
			require("harpoon"):list():select(3)
		end, { desc = "Harpoon Select 3" })
		vim.keymap.set("n", "<C-l>", function()
			require("harpoon"):list():select(4)
		end, { desc = "Harpoon Select 4" })
	end,
}
