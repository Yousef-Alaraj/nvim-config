return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Loads the plugin right before saving
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- You can customize some of the format options for the filetype
			rust = { "rustfmt", lsp_format = "fallback" },
			-- Conform will run the first available formatter
			javascript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			-- ADD MARKDOWN HERE
			markdown = { "prettier" },
			json = { "prettier" },
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
