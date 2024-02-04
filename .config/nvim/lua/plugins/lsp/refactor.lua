return {
	"ThePrimeagen/refactoring.nvim",
		--stylua: ignore
		keys = {
			{ "<leader>ce", function() require("refactoring").refactor("Extract Function") end, mode = "x", desc="extract func" },
			{ "<leader>cf", function() require("refactoring").refactor("Extract Function To File") end, mode = "x", desc="extract func to file" },
			-- Extract cunction supports only visual mode
			{ "<leader>cv", function() require("refactoring").refactor("Extract Variable") end, mode = "x", desc="extract var" },
			-- Extract cariable supports only visual mode
			{ "<leader>cI", function() require("refactoring").refactor("Inline Function") end, mode = "n", desc="extract inline func" },
			-- Inline fcnc supports only normal
			{ "<leader>ci", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, desc="extract inline var" },
			-- Inline vcr supports both normal and visual mode
			{ "<leader>cb", function() require("refactoring").refactor("Extract Block") end, mode = "n", desc="extract to block" },
			{ "<leader>cbf", function() require("refactoring").refactor("Extract Block To File") end, mode = "n", desc="extract block to file" },
			-- Extract block supports only normal mode
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
