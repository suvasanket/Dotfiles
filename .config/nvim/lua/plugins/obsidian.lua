return {
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		keys = {
			{ "<leader>fn", "<cmd>ObsidianQuickSwitch<cr>", desc = "notes" },
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
				enable = false,
			},
		},
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown",
		ft = "markdown",
		config = function()
			require("render-markdown").setup({
				bullet = {
					enabled = true,
					icons = { " ", "○ ", "◆ ", "◇ " },
					highlight = "RenderMarkdownBullet",
				},
				heading = {
					enabled = true,
					sign = true,
					icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
					signs = { "# " },
				},
			})
		end,
	},
}
