return {
	{
		"suvasanket/oz.nvim",
		dir = "~/Developer/oz-nvim",
		-- event = "VeryLazy",
		lazy = false,
		keys = {
			{ "<leader>aq", "<cmd>TermClose<cr>" },
			{ "<leader>aa", "<cmd>TermToggle<cr>" },
			{ "<leader><cr>", "<cmd>Term<cr>" },
		},

		config = function()
			require("oz").setup({
				oz_git = {
					win_type = "e",
				},
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
			})
		end,
	},
}
