return {
	"nvim-pack/nvim-spectre",
	keys = {
		{ "<leader>s", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
	},
	config = function()
		require("spectre").setup({})
	end,
}
