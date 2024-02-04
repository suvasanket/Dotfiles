return {
	--Mason
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Mason" },
		opts = {
			ui = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			},
		},
	},
}
