return {
	-- mason --
	{
		"williamboman/mason.nvim",
		event = "BufReadPost",
		opts = {},
	},

	-- formatter --
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
				ejs = { "prettier" },
				html = { "prettier" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
