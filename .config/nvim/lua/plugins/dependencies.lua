return {
	-- kind
	{
		"onsails/lspkind.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("lspkind").init({
				symbol_map = {
					Variable = "󰫧",
				},
			})
		end,
	},

	--dressing
	{
		"stevearc/dressing.nvim",
		enabled = false,
		event = { "LspAttach" },
		opts = {
			input = {
				mappings = {
					n = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<C-p>"] = "HistoryPrev",
						["<C-n>"] = "HistoryNext",
					},
				},
			},
			select = {
				telescope = require("telescope.themes").get_dropdown({
					borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
					prompt_title = false,
					layout_config = {
						height = 0.4,
					},
				}),
				get_config = function(opts)
					if opts.kind == "codeaction" then
						return {
							telescope = require("telescope.themes").get_cursor({
								borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
								prompt_prefix = " "
							}),
						}
					end
				end,
			},
		},
	},
}
