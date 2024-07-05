return {
	{
		"tpope/vim-sleuth",
		event = "BufRead",
	},
	{
		"tpope/vim-unimpaired",
		event = "VeryLazy"
	},
	{
		"ku1ik/vim-pasta",
		event = "BufRead",
	},
	{
		"moll/vim-bbye",
		keys = {
			{ "<C-S-\\>", "<cmd>Bdelete<cr>", desc = "delete buffer" },
		},
	},
	{
		"kazhala/close-buffers.nvim",
		keys = {
			{ "zx", "<cmd>BDelete hidden<cr>", desc = "delete buffer" },
			{ "zX", "<cmd>BDelete all<cr>", desc = "delete buffer" },
		},
	},
}
