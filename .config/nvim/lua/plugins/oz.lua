return {
	{
		"suvasanket/oz.nvim",
		dir = "~/Developer/oz-nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>aq", "<cmd>TermClose<cr>" },
			{ "<leader>aa", "<cmd>TermToggle<cr>" },
			{ "<leader><cr>", "<cmd>Term<cr>" },
		},

		opts = {
			oz_make = {
				override_make = true,
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
