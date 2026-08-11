-- WHICH KEYS

do
    vim.pack.add({ "https://github.com/folke/which-key.nvim" })
    require("which-key").setup({
        -- Delay between pressing a key and opening which-key (milliseconds)
        delay = 0,
        icons = { mappings = vim.g.have_nerd_font },
        -- Document existing key chains
        spec = {
            { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
            { "gr", group = "LSP Actions", mode = { "n" } },
        },
    })
end

-- GITSIGNS

do
    vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
    require("gitsigns").setup({
        signs = {
            add = { text = "+" }, ---@diagnostic disable-line: missing-fields
            change = { text = "~" }, ---@diagnostic disable-line: missing-fields
            delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
            topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
            changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
        },
    })
end

-- GUESS-INDENT

do
    vim.pack.add({ "https://github.com/NMAC427/guess-indent.nvim" })
    require("guess-indent").setup({})
end

-- THEME

do
    vim.pack.add({ "https://github.com/catppuccin/nvim" })

    require("catppuccin").setup({
        flavour = "mocha",
        styles = {
            comments = { "italic" },
        },
    })

    vim.cmd.colorscheme("catppuccin-nvim")
end
