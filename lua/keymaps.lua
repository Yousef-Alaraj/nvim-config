-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

-- File Explorer: Return to netrw / directory view
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project View (Netrw)", noremap = true, silent = true })

-- Clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Keep visual selection highlighted when indenting block
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move selected lines up/down in Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Keep cursor centered when scrolling half-pages or jumping search results
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Paste without replacing register contents with highlighted text
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over without losing clipboard", noremap = true, silent = true })

-- Delete without replacing register contents with highlighted text
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Replace all occurances of text under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
