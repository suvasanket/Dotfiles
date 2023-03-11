return {
	--nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", event = { "BufRead", "BufNewFile" } },
			{ "hrsh7th/cmp-buffer", event = "BufRead" },
			{ "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
			{ "hrsh7th/cmp-path", event = "InsertEnter" },
		},
		config = function()
			require("cmp").setup({
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol",
						maxwidth = 20,
						ellipsis_char = "..",
						before = function(entry, vim_item)
							return vim_item
						end,
					}),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = require("cmp").config.window.bordered(),
					documentation = require("cmp").config.window.bordered(),
				},

				experimental = {
					native_menu = false,
					ghost_text = false,
				},

				mapping = require("cmp").mapping.preset.insert({
					["<C-u>"] = require("cmp").mapping.scroll_docs(-4),
					["<C-d>"] = require("cmp").mapping.scroll_docs(4),
					["<C-o>"] = require("cmp").mapping.abort(),
					["<CR>"] = require("cmp").mapping.confirm({ select = true }),
					["<tab>"] = function(fallback)
						if require("cmp").visible() then
							require("cmp").select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							require("luasnip").expand_or_jump()
						elseif has_words_before() then
							require("cmp").complete()
						else
							fallback()
						end
					end,
					["<s-tab>"] = function(fallback)
						if require("cmp").visible() then
							require("cmp").select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end,
					["<S-CR>"] = require("cmp").mapping.confirm({
						behavior = require("cmp").ConfirmBehavior.Replace,
						select = true,
					}),
				}),
				sources = require("cmp").config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-- Set configuration for specific filetype.
			require("cmp").setup.filetype("gitcommit", {
				sources = require("cmp").config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			})

			require("cmp").setup.cmdline({ "/", "?" }, {
				mapping = require("cmp").mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			require("cmp").setup.cmdline(":", {
				mapping = require("cmp").mapping.preset.cmdline(),
				sources = require("cmp").config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("lspconfig")["jdtls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["lua_ls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["tsserver"].setup({
				capabilities = capabilities,
			})
		end,
	},

	--Codeium
	{
		"Exafunction/codeium.vim",
		cmd = "Codeium Enable",
		config = function()
			vim.keymap.set("i", "<C- >", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-[>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-]>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-->", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
}
