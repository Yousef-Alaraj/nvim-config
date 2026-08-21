-- TELESCOPE

do
    local telescope_plugins = {
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-telescope/telescope.nvim",
        "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    }
    if vim.fn.executable("make") == 1 then
        table.insert(telescope_plugins, "https://github.com/nvim-telescope/telescope-fzf-native.nvim")
    end

    -- NOTE: You can install multiple plugins at once
    vim.pack.add(telescope_plugins)

    -- See `:help telescope` and `:help telescope.setup()`
    require("telescope").setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
            ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
    -- If you later switch picker plugins, this is where to update these mappings.
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
        callback = function(event)
            local buf = event.buf

            -- Find references for the word under your cursor.
            vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

            -- Jump to the implementation of the word under your cursor.
            -- Useful when your language has ways of declaring types without an actual implementation.
            vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })

            -- Jump to the definition of the word under your cursor.
            -- This is where a variable was first declared, or where a function is defined, etc.
            -- To jump back, press <C-t>.
            vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

            -- Fuzzy find all the symbols in your current document.
            -- Symbols are things like variables, functions, types, etc.
            vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })

            -- Fuzzy find all the symbols in your current workspace.
            -- Similar to document symbols, except searches over your entire project.
            vim.keymap.set(
                "n",
                "gW",
                builtin.lsp_dynamic_workspace_symbols,
                { buffer = buf, desc = "Open Workspace Symbols" }
            )

            -- Jump to the type of the word under your cursor.
            -- Useful when you're not sure what type a variable is and you want to see
            -- the definition of its *type*, not where it was *defined*.
            vim.keymap.set(
                "n",
                "grt",
                builtin.lsp_type_definitions,
                { buffer = buf, desc = "[G]oto [T]ype Definition" }
            )
        end,
    })

    -- Override default behavior and theme when searching
    vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
        }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
        })
    end, { desc = "[S]earch [/] in Open Files" })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config"), follow = true })
    end, { desc = "[S]earch [N]eovim files" })
end

-- CONFORM

do
    vim.pack.add({
        "https://github.com/stevearc/conform.nvim",
    })

    require("conform").setup({
        -- Map filetypes to the formatters you want to use
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { "clang-format" },
        },

        -- Automatically format when you save a file
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    })

    -- Optional: Create a keybind to manually format at any time
    vim.keymap.set("", "<leader>f", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
    end, { desc = "[F]ormat buffer" })
end

-- LUASNIP

do
    -- [[ Snippet Engine ]]

    -- NOTE: You can also specify plugin using a version range for its git tag.
    --  See `:help vim.version.range()` for more info
    vim.pack.add({ { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") } })
    require("luasnip").setup({})

    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

    -- `friendly-snippets` contains a variety of premade snippets.
    --    See the README about individual language/framework/plugin snippets:
    --    https://github.com/rafamadriz/friendly-snippets
    --
    -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
    -- require('luasnip.loaders.from_vscode').lazy_load()
end

-- BLINK

do
    -- [[ Autocomplete Engine ]]
    vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } })
    require("blink.cmp").setup({
        keymap = {
            -- 'default' (recommended) for mappings similar to built-in completions
            --   <c-y> to accept ([y]es) the completion.
            --    This will auto-import if your LSP supports it.
            --    This will expand snippets if the LSP sent a snippet.
            -- 'super-tab' for tab to accept
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- For an understanding of why the 'default' preset is recommended,
            -- you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            --
            -- All presets have the following mappings:
            -- <tab>/<s-tab>: move to right/left of your snippet expansion
            -- <c-space>: Open menu or open docs if already open
            -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
            -- <c-e>: Hide menu
            -- <c-k>: Toggle signature help
            --
            -- See `:help blink-cmp-config-keymap` for defining your own keymap
            preset = "default",

            -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        completion = {
            -- By default, you may press `<c-space>` to show the documentation.
            -- Optionally, set `auto_show = true` to show the documentation after a delay.
            documentation = { auto_show = false, auto_show_delay_ms = 500 },
        },

        sources = {
            default = { "lsp", "path", "snippets" },
        },

        snippets = { preset = "luasnip" },

        -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
        -- which automatically downloads a prebuilt binary when enabled.
        --
        -- By default, we use the Lua implementation instead, but you may enable
        -- the rust implementation via `'prefer_rust_with_warning'`
        --
        -- See `:help blink-cmp-config-fuzzy` for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },

        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },
    })
end

-- TREESITTER

do
    -- [[ Configure Treesitter ]]
    --  Used to highlight, edit, and navigate code
    --
    --  See `:help nvim-treesitter-intro`

    -- NOTE: You can also specify a branch or a specific commit
    vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })

    -- Ensure basic parsers are installed
    local parsers =
        { "bash", "c", "cpp", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
    require("nvim-treesitter").install(parsers)

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
        -- Check if a parser exists and load it
        if not vim.treesitter.language.add(language) then
            return
        end
        -- Enable syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- Enable treesitter based folds
        -- For more info on folds see `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- Check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

        -- Enable treesitter based indentation
        if has_indent_query then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end

    local available_parsers = require("nvim-treesitter").get_available()
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local buf, filetype = args.buf, args.match

            local language = vim.treesitter.language.get_lang(filetype)
            if not language then
                return
            end

            local installed_parsers = require("nvim-treesitter").get_installed("parsers")

            if vim.tbl_contains(installed_parsers, language) then
                -- Enable the parser if it is already installed
                treesitter_try_attach(buf, language)
            elseif vim.tbl_contains(available_parsers, language) then
                -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
                require("nvim-treesitter").install(language):await(function()
                    treesitter_try_attach(buf, language)
                end)
            else
                -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                treesitter_try_attach(buf, language)
            end
        end,
    })
end

-- AUTOPAIR

do
    vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
    require("nvim-autopairs").setup({})
end

-- HARPOON

do
    vim.pack.add({ { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" } })
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
end

-- UNDOTREE

do
    vim.pack.add({ "https://github.com/mbbill/undotree" })
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

-- COMPETITEST

do
    -- 1. Install both the plugin and its required UI dependency
    vim.pack.add({
        "https://github.com/MunifTanjim/nui.nvim",
        "https://github.com/xeluxee/competitest.nvim",
    })

    -- 2. Register your keymaps using the native API
    vim.keymap.set("n", "<leader>tt", "<cmd>CompetiTest run<CR>", { desc = "Run Testcases" })
    vim.keymap.set(
        "n",
        "<leader>ti",
        '<cmd>vsplit | term /opt/homebrew/bin/g++-16 -O2 -std=c++20 "%" -o "%:r" && "./%:r"<CR>i',
        { desc = "Run Interactively" }
    )

    -- I highly recommend adding these two as well for fast local testing
    vim.keymap.set("n", "<leader>ta", "<cmd>CompetiTest add_testcase<CR>", { desc = "Add Testcase" })
    vim.keymap.set("n", "<leader>te", "<cmd>CompetiTest edit_testcase<CR>", { desc = "Edit Testcase" })

    -- 3. Configure the plugin
    require("competitest").setup({
        start_receiving_persistently_on_setup = true,
        received_files_extension = "cpp",

        received_problems_path = "$(JAVA_TASK_CLASS).$(FEXT)",
        received_contests_directory = ".",
        received_contests_problems_path = "$(JAVA_TASK_CLASS).$(FEXT)",

        -- FIX: Replaced vim.fn.expand with the native $(HOME) modifier.
        -- Evaluating vim.fn at load time can sometimes cause path resolution issues
        -- before the editor has fully initialized its working directories.
        template_file = {
            cpp = os.getenv("HOME") .. "/Desktop/competitive-programming/template.cpp",
        },

        compile_command = {
            cpp = {
                exec = "/opt/homebrew/bin/g++-16",
                args = { "-O2", "-std=c++20", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" },
            },
        },

        run_command = {
            cpp = {
                exec = "./$(FNOEXT)",
            },
        },

        testcases_use_single_file = true,
        evaluate_template_modifiers = true,
        multiple_testing = -1,

        -- "squish" is the perfect setting here. It strips trailing spaces and newlines,
        -- preventing those frustrating "Wrong Answer" verdicts on local tests when
        -- the actual logic is perfectly sound.
        output_compare_method = "squish",
    })
end
