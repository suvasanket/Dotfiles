return {
	--noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			routes = {
				{
					view = "mini",
					filter = { event = "msg_showmode" },
				},
			},
			lsp = {
				progress = {
					enabled = true,
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = false,
				long_message_to_split = true,
			},
		},
	},

	--nvim-notify
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 2000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.45)
			end,
			render = "minimal",
			stages = "slide",
		},
	},
	--nui
	{ "MunifTanjim/nui.nvim", lazy = true },

	--dressing
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
}
