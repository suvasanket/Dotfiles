return {
	-- fidget
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			progress = {
				display = {
					done_style = "@attribute",
				},
			},
		},
	},

	-- quicker
	{
		"stevearc/quicker.nvim",
		ft = "qf",
		opts = {
			opts = {
				number = true,
				wrap = true,
			},
		},
	},
}
