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

	-- clue
	{
		"echasnovski/mini.clue",
		event = "VeryLazy",
		config = function()
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- master
					{ mode = "n", keys = "\\" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					-- `z` key
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},

				clues = {
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},

				window = {
					config = {},
					delay = 500,
				},
			})
		end,
	},

	-- picker
	{
		"echasnovski/mini.pick",
		dependencies = {
			"echasnovski/mini.extra",
		},
		keys = {
			{ "<leader>pg", "<cmd>Pick grep_live<cr>", desc = "live grep" },
			{ "<leader>pf", "<cmd>Pick files<cr>", desc = "find files" },
			{ "<leader>sh", "<cmd>Pick help<cr>", desc = "find files" },
			{
				"<leader>pc",
				"<cmd>lua MiniPick.builtin.files({tool = 'fd'}, { source = { cwd = '~/.config' } })<cr>",
				desc = "config",
			},
			{
				"<C-f>",
				function()
					local function find_in(wd)
						require("mini.pick").builtin.files({ tool = "fd" }, {
							source = { cwd = wd },
							mappings = {
								global = {
									char = "<C-f>",
									func = function()
										find_in("~/")
									end,
								},
								string = {
									char = "<C-s>",
									func = function()
										require("mini.extra").pickers.explorer()
									end,
								},
								explore = {
									char = "<C-e>",
									func = function()
										require("mini.extra").pickers.explorer()
									end,
								},
								old = {
									char = "<C-o>",
									func = function()
										require("mini.extra").pickers.oldfiles()
									end,
								},
							},
						})
					end

					-- function call
					if vim.fn.getcwd() == os.getenv("HOME") then
						require("mini.extra").pickers.oldfiles()
					else
						find_in(GetProjectRoot())
					end
				end,
				desc = "find files",
			},
		},
		config = function()
			require("mini.pick").setup({
				mappings = {
					delete_char = "<C-h>",
					scroll_left = "<C-b>",
					choose_marked = "<C-q>",

					toggle_info = "<M-i>",
					toggle_preview = "<C-p>",
					mark = "<Tab>",
					mark_all = "<S-Tab>",

					move_down = "<C-j>",
					move_start = "<C-g>",
					move_up = "<C-k>",

					choose_in_split = "",
				},
				window = {
					prompt_cursor = "⎸",
				},
			})
		end,
	},
	{
		"echasnovski/mini.extra",
		lazy = true,
		config = function()
			require("mini.extra").setup()
		end,
	},
}
