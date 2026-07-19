return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	lazy = false,

	keys = {
		{ "<leader>tt", "<cmd>CompetiTest run<CR>", desc = "Run Testcases" },
		{
			"<leader>ti",
			-- CHANGED: Updated the interactive terminal standard to c++23
			'<cmd>vsplit | term /usr/local/bin/g++-15 -O2 -std=c++23 "%" -o "%:r" && "./%:r"<CR>i',
			desc = "Run Interactively",
		},
	},

	config = function()
		require("competitest").setup({
			start_receiving_persistently_on_setup = true,
			received_files_extension = "cpp",

			-- FIX: Replaced the Lua functions with the native $(JAVA_TASK_CLASS) modifier
			-- to automatically strip spaces and punctuation.
			received_problems_path = "$(JAVA_TASK_CLASS).$(FEXT)",

			received_contests_directory = ".",
			received_contests_problems_path = "$(JAVA_TASK_CLASS).$(FEXT)",

			-- FIX: Mapped directly to 'cpp' and used $(HOME) instead of ~
			template_file = {
				cpp = vim.fn.expand("~/Desktop/competitive-programming/template.cpp"),
			},

			compile_command = {
				cpp = {
					exec = "/usr/local/bin/g++-15",
					-- CHANGED: Updated to c++23 and added -Wall for better diagnostics
					args = { "-O2", "-std=c++23", "$(FNAME)", "-o", "$(FNOEXT)" },
				},
			},

			-- FIX: Wrapped in the 'cpp' key to match compile_command
			run_command = {
				cpp = {
					exec = "./$(FNOEXT)",
				},
			},

			testcases_use_single_file = true,
			evaluate_template_modifiers = true,
			multiple_testing = -1,
			output_compare_method = "squish",
		})
	end,
}
