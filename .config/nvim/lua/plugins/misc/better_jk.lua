return {
	--jk
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "kj" }, -- a table with mappings to use
				keys = function()
					return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
				end,
			})
		end,
	},
	{
		"rainbowhxch/accelerated-jk.nvim",
		keys = {
			{ "j", "<Plug>(accelerated_jk_gj)" },
			{ "k", "<Plug>(accelerated_jk_gk)" },
		},
		config = function() end,
	},
}
