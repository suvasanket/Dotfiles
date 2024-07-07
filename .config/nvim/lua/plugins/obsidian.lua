return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	keys = {
		{ "<leader>fn", "<cmd>ObsidianQuickSwitch<cr>" },
	},
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "Notes",
				path = "~/Documents/Obsidian Vault/Notes",
			},
		},
		ui = {
			enable = true,
		}
	},
}
