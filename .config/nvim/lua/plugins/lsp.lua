return {
	-- lsp-config --
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- lsp config --
			local lsp = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			--lsp on_attach
			local on_attach = function(client, bufnr)
				--inlay hint
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(false)
				end
			end

			-- lsp default_config
			lsp.util.default_config = vim.tbl_extend("force", lsp.util.default_config, {
				capabilities = capabilities,
				on_attach = on_attach,
			})
			-- * manual * --

			lsp.solargraph.setup({})
			lsp.clangd.setup({})

			-- * manual * --

			-- mason --
			require("mason").setup({
				ui = {
					border = "single",
				},
			})

			require("mason-lspconfig").setup()
			-- server setup --
			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,
			})
			require("lspconfig.ui.windows").default_options.border = "single"
		end,
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
			},
            default_format_opts = {
                lsp_format = "fallback",
            },
		},
	},
}
