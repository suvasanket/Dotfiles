return {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	opts = {
		keys = {
			{ "<C-q>", "<cmd>Clearqflist<cr>", desc = "clear quickfix list" },
		},
		opts = {
			number = true,
		},
	},
}
