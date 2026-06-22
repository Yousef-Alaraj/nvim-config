return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Load the snippet library
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})

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
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason").setup()

			-- Let Mason handle the setup of the servers
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd" },
				handlers = {
					-- 1. Default handler for all servers
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- 2. Dedicated handler for clangd to force GCC 15 headers
					["clangd"] = function()
						require("lspconfig").clangd.setup({
							capabilities = capabilities,
							cmd = {
								"clangd",
								"--query-driver=/usr/local/bin/g++-15",
								"--background-index",
								-- "--clang-tidy",
								"--header-insertion=never",
							},
						})
					end,
				},
			})
		end,
	},
}
