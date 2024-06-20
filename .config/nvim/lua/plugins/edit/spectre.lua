return {
	"nvim-pack/nvim-spectre",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{
			mode = "v",
			"<leader>rs",
			'<esc><cmd>lua require("spectre").open_visual()<CR>',
			desc = "Search current word",
		},
		{
			mode = "n",
			"<leader>rs",
			'<cmd>lua require("spectre").toggle()<CR>',
			desc = "Toggle Spectre",
		},
	},
}
