return {
	--recorder
	{
		"chrisgrieser/nvim-recorder",
		keys = {
			{ "Q", desc = "recorder" },
			{ "q", desc = "play" },
			{ "<leader>qc", desc = "change macro" },
			{ "<leader>qe", desc = "modify macro" },
			{ "<leader>qy", desc = "copy macro" },
			{ "<leader>qb", desc = "break macro" },
		},
		opts = {
			clear = true,
			mapping = {
				startStopRecording = "Q",
				playMacro = "q",
				switchSlot = "<leader>qc",
				editMacro = "<leader>qe",
				yankMacro = "<leader>qy",
				addBreakPoint = "<leader>qb",
			},
			lessNotifications = false,
		},
	},
	--mini ai
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					m = ai.gen_spec.treesitter({
						a = "@function.outer",
						i = "@function.inner",
					}, {}),
					c = ai.gen_spec.treesitter({
						a = "@class.outer",
						i = "@class.inner",
					}, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},
	--J
	{
		"Wansmer/treesj",
		keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Split/Join" } },
		opts = {
			use_default_keymaps = false,
			max_join_length = 220,
			notify = false,
		},
	},
}
