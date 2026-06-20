return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Loads the plugin right before saving
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			markdown = { "prettier" },
			json = { "prettier" },
			-- Add this line:
			cpp = { "clang-format" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--print-width", "80", "--prose-wrap", "preserve" },
			},
		},
		-- This replaces your custom autocmd
		format_on_save = {
			timeout_ms = 5000,
			lsp_format = "fallback",
		},
	},
}
