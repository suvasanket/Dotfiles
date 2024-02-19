return {
	"ojroques/nvim-bufdel",
	config=function ()
		require('bufdel').setup {
		  quit = false,  -- quit Neovim when last buffer is closed
		}
	end,
	keys = {
		{ "zx", "<cmd>BufDel<cr>", desc = "buffer delete" },
		{ "zc", "<cmd>BufDelOthers<cr>", desc = "buffer delete other" },
	},
}
