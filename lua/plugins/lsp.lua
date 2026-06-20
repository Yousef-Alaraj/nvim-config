return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			-- --- DIAGNOSTICS CONFIG ---
			vim.diagnostic.config({
				virtual_text = true, -- This is the magic toggle for the inline text
				signs = true, -- Shows the E/W/H/I icons in the left gutter
				underline = true, -- Squiggly lines under the actual error
				update_in_insert = false, -- Wait until you exit Insert mode to show errors
				severity_sort = true, -- Show the most critical errors first
			})
			-- --------------------------
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}),
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason").setup()

			-- --- THE C++ FIX ---
			-- Force clangd to use GCC and strictly define the root folder
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--query-driver=/usr/local/bin/g++-15",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=never",
				},
				-- This tells clangd: "If you see compile_flags.txt, this is the root project."
				root_markers = { "compile_flags.txt", ".git" },
			})
			-- -------------------

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd" },
				handlers = {
					function(server_name)
						if server_name ~= "clangd" then
							vim.lsp.config(server_name, { capabilities = capabilities })
						end
						vim.lsp.enable(server_name)
					end,
				},
			})
		end,
	},
}
