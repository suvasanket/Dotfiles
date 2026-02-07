return {
	"suvasanket/buf_mark.nvim",
    -- dir = "~/Developer/buf_mark-nvim/",
	keys = { "'", "m" },
	cmd = { "Find" },
	config = function()
		require("buf_mark").setup({
			mappings = {
				jump_key = "'",
				marker_key = "m",
			},
		})
	end,
}
