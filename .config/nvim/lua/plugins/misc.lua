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

	-- quick snippet capture
	{
		"chrisgrieser/nvim-scissors",
		keys = {
			{
				"<leader>se",
				function()
					require("scissors").editSnippet()
				end,
				desc = "create Snippet",
			},
			{
				"<leader>sa",
				function()
					require("scissors").addNewSnippet()
				end,
				mode = { "n", "x" },
				desc = "create Snippet",
			},
		},
		opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets" },
	},
}
