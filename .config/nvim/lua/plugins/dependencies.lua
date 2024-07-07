return {
	--lua plugins that are other to use
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },

	--web devicons
	{
		"nvim-tree/nvim-web-devicons",
		event = "VimEnter",
		config = function ()
			require("nvim-web-devicons").set_default_icon('', '#658147', 65)
		end
	},

	-- kind
	{
		"onsails/lspkind.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function ()
			require('lspkind').init({
				symbol_map = {
					Variable = "󰫧",
				}
			})
		end
	},

	--nui
	{ "MunifTanjim/nui.nvim", event = "VeryLazy" },

	--dressing
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
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
				get_config = function(opts)
					if opts.kind == "codeaction" then
						return {
							telescope = require("telescope.themes").get_cursor(),
						}
					end
				end,
			},
		},
	},
}
