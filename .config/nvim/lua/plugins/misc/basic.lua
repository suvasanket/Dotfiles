return {
	"echasnovski/mini.basics",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("mini.basics").setup({
			options = {
				win_borders = "single",
			},
		})
	end,
}
