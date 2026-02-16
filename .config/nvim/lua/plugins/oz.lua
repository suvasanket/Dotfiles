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

		config = function()
			require("oz").setup({
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
			-- statusline --
			require("oz.git").on_job_exit("statusline", {
				callback = function()
					update_git_branch()
				end,
			})
		end,
	},

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		opts = {
			use_icons = false,
		},
	},
}
