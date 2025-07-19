return {
	-- mason --
	{
		"williamboman/mason.nvim",
		event = "BufReadPost",
		opts = {},
	},

	-- null-ls --
	{
		"stevearc/conform.nvim",
		keys = {
			{ "<C-s>", "<cmd>lua require('conform').format()<cr>" },
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},

	-- trouble
	{
		"folke/trouble.nvim",
		opts = {
			focus = true,
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>cd",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
			},
			{ "grr", "<cmd>Trouble lsp_references toggle focus=true<cr>" },
		},
	},
}
