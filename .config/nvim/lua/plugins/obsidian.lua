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
				enable = true,
			},
		},
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = "markdown",
		enabled = false,
		config = function()
			require("render-markdown").setup({
				bullet = {
					enabled = true,
					icons = { " ", "○ ", "◆ ", "◇ " },
				},
				heading = {
					enabled = true,
					sign = false,
					icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰲧 ', '󰲩 ', '󰲫 ' },
				},
				code = {
					sign = false,
				}
			})
		end,
	},
}
