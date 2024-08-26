return {
	{
		"echasnovski/mini.trailspace",
		event = "BufRead",
		keys = { { "<leader>bt", "<cmd>lua MiniTrailspace.trim()<cr>", desc = "trim whitespaces" } },
		config = function()
			require("mini.trailspace").setup({
				only_in_normal_buffers = true,
			})
		end,
	},

	{
		"romainl/vim-cool",
		event = { "BufReadPost" },
	},

	{
		"tpope/vim-sleuth",
		event = "BufRead",
	},
}
