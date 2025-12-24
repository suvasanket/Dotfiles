return {
	{
		"suvasanket/oz.nvim",
		dir = "~/Developer/oz-nvim",
		event = "VeryLazy",
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
			oz_git = {
				win_type = "hor",
			},
			integration = {
				oil = {
					entry_exec = {
						use_fullpath = false,
					},
				},
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
