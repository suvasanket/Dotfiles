return {
	"rgroli/other.nvim",
	keys = {
		{ "<C-a>", "<cmd>Other<cr>" },
		{ "<leader>a", "<cmd>OtherClear<cr>" },
	},
	config = function()
		require("other-nvim").setup({
			mappings = {
				"rails",
			},
		})
	end,
}
