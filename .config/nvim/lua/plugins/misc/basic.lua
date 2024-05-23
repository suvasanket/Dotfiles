return {
	"echasnovski/mini.basics",
	version = "*",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("mini.basics").setup({
			options = {
				win_borders = "single",
				mappings = {
					basic = false,
					windows = false,
				},
			},
		})
	end,
}
