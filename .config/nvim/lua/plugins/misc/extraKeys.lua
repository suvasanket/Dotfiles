return {
	-- jk
	{
		"rainbowhxch/accelerated-jk.nvim",
		keys = {
			{ "j", "<Plug>(accelerated_jk_gj)" },
			{ "k", "<Plug>(accelerated_jk_gk)" },
		},
		config = function() end,
	},
	-- [  ]
	{
		"tpope/vim-unimpaired",
		event = "VeryLazy",
	},
}
