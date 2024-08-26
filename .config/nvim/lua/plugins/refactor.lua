return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		--stylua: ignore
		{ "<leader>ri", ":Refactor inline_var", desc = "refactor inline_var",  mode = { "n", "x" } },
		{ "<leader>rf", ":Refactor inline_func", desc = "refactor inline_func", mode = { "n", "x" } },
		{ "<leader>ri", ":Refactor extract_var<cr>", mode = "x", desc = "extract to var" },
		{ "<leader>rf", ":Refactor extract<cr>", mode = "x", desc = "extract to func" },
		{ "<leader>rp", ":Refactor extract_to_file<cr>", mode = "x", desc = "extract to file" },
		{ mode = { "n", "x" }, "<leader>rr", function() require("refactoring").select_refactor() end ,desc = "refactor menu"},

		{ mode = { "n", "x" }, "<leader>dp", function() require("refactoring").debug.print_var() end ,desc = "print_var"},
		{ mode = { "n", "x" }, "<leader>df", function() require("refactoring").debug.printf() end ,desc = "printf"},
		{ mode = { "n", "x" }, "<leader>dx", function() require("refactoring").debug.cleanup() end ,desc = "cleanup print"},
	},
	opts = {
		prompt_func_return_type = {
			go = false,
			java = true,

			cpp = false,
			c = true,
			h = true,
			hpp = false,
			cxx = false,
		},
		prompt_func_param_type = {
			go = false,
			java = true,

			cpp = false,
			c = true,
			h = true,
			hpp = false,
			cxx = false,
		},
		printf_statements = {},
		print_var_statements = {},
	},
}
