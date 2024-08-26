return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{ "<leader>cd", "<cmd>Trouble diagnostics toggle<cr>", desc = "diagnostics" },
		{ "<leader>cR", "<cmd>Trouble lsp_references toggle<cr>", desc = "references" },
	},
	opts = {
		pinned = true,
		focus = true,
		keys = {},
	},
}
