return {
	--lsp-config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			require("lspconfig.ui.windows").default_options.border =
				{ "┌", "─", "┐", "│", "┘", "─", "└", "│" }
			require("mason").setup({
				ui = {
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				},
			})
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				-- default handler.
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				-- ["rust_analyzer"] = function ()
				-- 	require("rust-tools").setup {}
				-- end
			})
		end,
	},
	--lsptimeout
	{ "hinell/lsp-timeout.nvim", event = "LspAttach" },
}
