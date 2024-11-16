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
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	}
}
