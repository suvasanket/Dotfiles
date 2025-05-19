return {
	{
		"suvasanket/oz.nvim",
		dir = "~/codes/projects/oz-nvim",
		event = "VeryLazy",
		lazy = false,
		keys = {
			{ "<leader>aq", "<cmd>TermClose<cr>" },
			{ "<leader>aa", "<cmd>TermToggle<cr>" },
		},

		opts = {
			mappings = {
				Term = "<leader><cr>",
			},
			oz_make = {
				override_make = true,
			},
		},
	},

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		opts = {
			use_icons = false,
		},
	},
}
