return {
	-- mini ai
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},

	-- move
	{
		"echasnovski/mini.move",
		keys = {
			{ "<S-h>", mode = { "n", "x" } },
			{ "<S-j>", mode = { "n", "x" } },
			{ "<S-k>", mode = { "n", "x" } },
			{ "<S-l>", mode = { "n", "x" } },
		},
		config = function()
			require("mini.move").setup({
				mappings = {
					left = "<S-h>",
					right = "<S-l>",
					down = "<S-j>",
					up = "<S-k>",

					line_left = "<S-h>",
					line_right = "<S-l>",
					line_down = "<S-j>",
					line_up = "<S-k>",
				},
			})
		end,
	},

	-- extra
	{
		"echasnovski/mini.extra",
		lazy = true,
		config = function()
			require("mini.extra").setup()
		end,
	},

	-- visit
	{
		"echasnovski/mini.visits",
		lazy = true,
		config = function()
			require("mini.visits").setup()
		end,
	},
}
