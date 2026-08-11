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

-- STATUSLINE
do
    vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
    require("lualine").setup({
        options = {
            theme = "auto",
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

-- MINI

do
    vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

    -- If a nerd font is available, load the icons module for pretty icons in various plugins.
    if vim.g.have_nerd_font then
        require("mini.icons").setup()
        -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
        MiniIcons.mock_nvim_web_devicons()
    end

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({
        -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
        mappings = {
            around_next = "aa",
            inside_next = "ii",
        },
        n_lines = 500,
    })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()
end
