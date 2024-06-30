return {
	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>xx", "<cmd>OverseerToggle<cr>", desc = "OverseerToggle" },
			{ "<leader>xr", "<cmd>OverseerRun<cr>", desc = "run" },
			{ "<leader>xc", "<cmd>MakeC<cr>", desc = "Make cur" },
		},
		cmd = {
			"Make",
			"Run",
			"OverseerRun",
		},
		opts = {
			templates = { "builtin", "node" },
		},
		dependencies = {
			{
				"pianocomposer321/officer.nvim",
				opts = {},
			},
		},
	},
}
