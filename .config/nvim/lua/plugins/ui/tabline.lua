return {
	"romgrk/barbar.nvim",
	event = "FileType",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = true
	end,
	opts = {
		-- animation = true,
		-- insert_at_start = true,
		auto_hide = false,
	},
}
