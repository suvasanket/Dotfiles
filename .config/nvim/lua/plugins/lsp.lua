return {
	-- lsp-config --
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		-- event = "FileType",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			servers = {
				lua_ls = {},
                ts_ls = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")

            local On_attach = function(client, bufnr)
                --inlay hint
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(false)
                end
            end

			for server, config in pairs(opts.servers) do
				-- config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                config.on_attach = On_attach
				lspconfig[server].setup(config)
			end

			require("lspconfig.ui.windows").default_options.border = "single"
		end,
	},

	-- mason --
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = function()
			require("mason").setup({
				ui = {
					border = "single",
				},
			})
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
