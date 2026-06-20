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

			-- Replaces spaces in the problem name with underscores
			received_problems_path = function(task, file_ext)
				local safe_name = string.gsub(task.name, " ", "_")
				return safe_name .. "." .. file_ext
			end,

			received_contests_directory = ".",

			-- Applies the same space-to-underscore fix for full contests
			received_contests_problems_path = function(task, file_ext)
				local safe_name = string.gsub(task.name, " ", "_")
				return safe_name .. "." .. file_ext
			end,

			template_file = "~/Desktop/competitive-programming/template.cpp",

			compile_command = {
				cpp = {
					exec = "/usr/local/bin/g++-15",
					-- CHANGED: Updated to c++23 and added -Wall for better diagnostics
					args = { "-O2", "-std=c++23", "$(FNAME)", "-o", "$(FNOEXT)" },
				},
			},
			run_command = {
				exec = "./$(FNOEXT)",
			},
			testcases_use_single_file = true,
			evaluate_template_modifiers = true,
		})
	end,
}
