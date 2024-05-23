return {
	"pianocomposer321/officer.nvim",
	dependencies = {
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>x", "<cmd>OverseerToggle<cr>" },
			{ "<leader>xc", "<cmd>OverseerRunCmd<cr>" },
		},
		opts = {},
	},
	keys = {
		{ "<leader>xx", "<cmd>w<cr><cmd>Make%<cr>", desc = "Make cur" },
	},
	cmd = {
		"Make",
		"Run",
	},
	opts = {},
}
