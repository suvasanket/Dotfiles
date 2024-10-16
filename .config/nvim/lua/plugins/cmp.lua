return {
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter",
		dependencies = "hrsh7th/cmp-nvim-lsp-signature-help"
	},
	{ "hrsh7th/cmp-buffer", event = { "InsertEnter", "CmdlineEnter" } },
	{ "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
	{ "hrsh7th/cmp-path", event = "InsertEnter" },
	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
	{ "onsails/lspkind.nvim", event = { "InsertEnter", "CmdlineEnter" } },
	--nvim-cmp
	{
		-- "hrsh7th/nvim-cmp",
		"iguanacucumber/magazine.nvim",
		name = "nvim-cmp",

		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
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
							luasnip = "󰇘",
						})[entry.source.name]

						return vim_item
					end,
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
						winblend = 7
					},
					documentation = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					}
				},
				completion = {
					keyword_length = 1,
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
					["<C-j>"] = function()
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							cmp.complete()
						end
					end,
				}),
			})

			-- git commit
			cmp.setup.filetype("gitcommit", {
				sources = {
					{ name = "buffer" },
				},
			})

			-- search
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer", keyword_length = 1 },
				},
			})

			-- cmdline
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<end>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "path", keyword_length = 1 },
					{ name = "cmdline", keyword_length = 1 },
				},
			})

			-- dadbod
			cmp.setup.filetype("sql", {
				sources = {
					{ name = "vim-dadbod-completion" },
				}
			})

			-- add braces
			cmp.event:on(
			'confirm_done',
			function(event)
				-- Get the completed item
				local entry = event.entry
				local item = entry:get_completion_item()

				-- Check if the item is a function
				if item.kind == cmp.lsp.CompletionItemKind.Function then
					-- Get the label of the completed item
					local label = item.label

					-- Check if the label ends with parentheses
					if not label:match('%(%)$') then
						-- If not, insert parentheses
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-g>U<Right>()<left>', true, false, true), 'n', false)
					end
				end
			end
			)
		end,
	},
}
