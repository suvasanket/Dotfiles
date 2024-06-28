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
	-- {
	-- 	"moll/vim-bbye",
	-- 	keys = {
	-- 		{ "zx", "<cmd>Bdelete<cr>", desc = "delete buffer" },
	-- 	},
	-- },
	{
		"Asheq/close-buffers.vim",
		keys = {
			{ "zx", "<cmd>Bdelete other<cr>", desc = "delete buffer" },
			{ "zc", "<cmd>Bdelete hidden<cr>", desc = "delete buffer" },
		},
	},
	{
		"mhinz/vim-sayonara",
		keys = {
			{ "<C-\\>", "<cmd>Sayonara<cr>", desc = "quit" },
		},
	},
}
