vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

local arrows = {
	["<Up>"] = "k",
	["<Down>"] = "j",
	["<Left>"] = "h",
	["<Right>"] = "l",
}

for key, target in pairs(arrows) do
	-- NORMAL MODE
	vim.keymap.set(
		"n",
		key,
		"<cmd>echohl ErrorMsg | echo ' NO ARROWS! Use " .. target .. " ' | echohl None<CR>",
		{ desc = "Force hjkl" }
	)

	-- VISUAL MODE: <cmd> natively executes without dropping your highlighted text
	vim.keymap.set(
		{ "v", "x" },
		key,
		"<cmd>echohl ErrorMsg | echo ' NO ARROWS! Use " .. target .. " ' | echohl None<CR>",
		{ desc = "Force hjkl" }
	)

	-- INSERT MODE: The <C-o> bypass trick to avoid nvim-cmp
	vim.keymap.set(
		"i",
		key,
		"<C-o><cmd>echohl ErrorMsg | echo ' NO ARROWS! Use " .. target .. " ' | echohl None<CR>",
		{ desc = "Force hjkl" }
	)
end
