--1.Lsp-config setup
--2.null_ls setup for formatting
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "jose-elias-alvarez/typescript.nvim", ft = "js" },
		event = { "BufRead", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local typescript = require("typescript")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			---------------------------------------------------------------------------------------------------------------------------------------------
			--LspSetup -----Here------

			-- configure html server
			lspconfig["html"].setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			}) --html

			-- configure java
			lspconfig["jdtls"].setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			}) --java

			-- configure typescript server with plugin
			typescript.setup({
				server = {
					capabilities = capabilities,
				},
			}) --ts/js

			-- configure css server
			lspconfig["cssls"].setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			}) --css

			-- configure tailwindcss server
			lspconfig["tailwindcss"].setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			}) --css

			-- configure emmet language server
			lspconfig["emmet_ls"].setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
			}) --emment

			-- configure lua server (with special settings)
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				settings = { -- custom settings for lua
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			}) --lua
		end, ---End of lsp-config
	},

	--Null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = "jayp0521/mason-null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting -- to setup formatters
			local diagnostics = null_ls.builtins.diagnostics -- to setup linters
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					--java
					formatting.clang_format,
					-- js/ts formatter
					formatting.prettier,
					-- lua formatter
					formatting.stylua,
					-- js/ts linter
					diagnostics.eslint_d.with({
						condition = function(utils)
							return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
						end,
					}),
				},
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										--  only use null-ls for formatting instead of lsp server
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}
