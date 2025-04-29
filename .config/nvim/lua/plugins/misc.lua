return {
	-- notify
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = { "BufReadPost" },
		config = function()
			require("notify").setup({
				render = "wrapped-compact",
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	},

	-- fidget
	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = { "LspAttach" },
		opts = {},
	},
}
