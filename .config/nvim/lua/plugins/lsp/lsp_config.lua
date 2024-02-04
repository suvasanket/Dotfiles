return {
	--lsp-config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lspconfig.ui.windows").default_options.border =
				{ "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		end,
	},

	--lsptimeout
	{ "hinell/lsp-timeout.nvim", event = "LspAttach" },

	--virtual text
	{
		"isaksamsten/better-virtual-text.nvim",
		event = "LspAttach",
		opts = {
			highlights = {
				BetterVirtualTextError = { link = "NonText" },
				BetterVirtualTextWarn = { link = "NonText" },
				BetterVirtualTextInfo = { link = "NonText" },
				BetterVirtualTextHint = { link = "NonText" },
				BetterVirtualTextPrefixError = { link = "DiagnosticSignError" },
				BetterVirtualTextPrefixWarn = { link = "DiagnosticSignWarn" },
				BetterVirtualTextPrefixInfo = { link = "DiagnosticSignInfo" },
				BetterVirtualTextPrefixHint = { link = "DiagnosticSignHint" },
			},
		},
	},
}
