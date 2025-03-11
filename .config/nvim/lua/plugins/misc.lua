return {
	{ "romainl/vim-cool", keys = { "/", "n", "N", "?", "*" } },

	{
		"kazhala/close-buffers.nvim",
		cmd = "BDelete",
		keys = {
			{
				"z'",
				function()
					vim.cmd([[BDelete hidden]])
					print("hidden buffers removed")
				end,
				desc = "delete hidden",
			},
		},
	},

	-- yank hist
	{
		"gbprod/yanky.nvim",
		keys = { { "<leader>p", "<cmd>YankyRingHistory<cr>" } },
		opts = {},
	},
}
