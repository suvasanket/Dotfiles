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
			-- statusline --
			require("oz.git").on_job_exit("statusline", {
				callback = function(ev)
					if ev.args[1] == "checkout" or ev.args[1] == "switch" then
						update_git_branch()
					end
				end,
			})
		end,
	},
}
