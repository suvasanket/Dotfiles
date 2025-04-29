return {
	{
		"suvasanket/oz.nvim",
		dir = "~/codes/projects/oz-nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>aq", "<cmd>TermClose<cr>" },
			{ "<leader>aa", "<cmd>TermToggle<cr>" },
		},

		opts = {
			mappings = {
				Term = "<leader><cr>",
			},

			integration = {
				oil = {
					cur_entry_splitter = ":",
				},
			},
			oz_make = {
				override_make = true,
			},
		},
	},

	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
}
