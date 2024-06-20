return {
	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
	{ "hrsh7th/cmp-buffer", event = { "InsertEnter", "CmdlineEnter" } },
	{ "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
	{ "hrsh7th/cmp-path", event = "InsertEnter" },
	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
	{ "onsails/lspkind.nvim", event = { "InsertEnter", "CmdlineEnter" } },
	--nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {},
		config = function()
			local cmp = require("cmp")
			-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "luasnip", keyword_length = 1 },
					{ name = "nvim_lsp", keyword_length = 1 },
					{ name = "buffer", keyword_length = 1 },
				},

				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind =
							require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						vim_item.menu = ({
							buffer = "󰎞",
							nvim_lsp = "󰅟",
							luasnip = "",
						})[entry.source.name]

						return vim_item
					end,
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
				},
				completion = {
					-- keyword_length = 4,
					completeopt = "menu,noselect",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				experimental = {
					ghost_text = false,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-a>"] = function()
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							cmp.complete()
						end
					end,
				}),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer", keyword_length = 1 },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<end>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "path", keyword_length = 1 },
					{ name = "cmdline", keyword_length = 1 },
				},
			})
		end,
	},
}
