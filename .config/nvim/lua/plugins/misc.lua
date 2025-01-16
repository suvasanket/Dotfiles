return {
	{
		"echasnovski/mini.trailspace",
		event = "BufRead",
		keys = { { "<leader>bt", "<cmd>lua MiniTrailspace.trim()<cr>", desc = "trim whitespaces" } },
		config = function()
			require("mini.trailspace").setup({
				only_in_normal_buffers = true,
			})
		end,
	},
	{
		"Wansmer/treesj",
		keys = { { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Split/Join" } },
		opts = {
			use_default_keymaps = false,
			max_join_length = 220,
			notify = false,
		},
	},

	{
		"romainl/vim-cool",
		event = { "BufReadPost" },
	},

	{
		"tpope/vim-sleuth",
		event = "BufRead",
	},
	{
		"kazhala/close-buffers.nvim",
		cmd = "BDelete",
		keys = {
			{
				"zh",
				function()
					vim.cmd([[BDelete hidden]])
					Notify("Hidden buffer removed")
				end,
				desc = "delete hidden",
			},
		},
	},

	-- yank hist
	{
		"ptdewey/yankbank-nvim",
		keys = {
			{ "<C-p>", "<cmd>YankBank<cr>", mode = { "n", "x" } },
			{ "d",     mode = { "n", "x" } },
			{ "y",     mode = { "n", "x" } },
			{ "c",     mode = { "n", "x" } },
			{ "D",     mode = { "n", "x" } },
			{ "d",     mode = { "n", "x" } },
			{ "Y",     mode = { "n", "x" } },
		},
		config = function()
			require("yankbank").setup({
				keymaps = {
					paste = "p",
					paste_back = "P",
				},
			})
		end,
	},

	-- hl undo
	{
		"tzachar/highlight-undo.nvim",
		keys = { { "u" }, { "<C-r>" }, { "p" }, { "P" } },
		opts = {
			duration = 500,
		},
	},
}
