return {
	--noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		keys = {
			{ "<esc>", "<cmd>Noice dismiss<cr>" },
		},
		opts = {
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
			},
			cmdline = {
				enabled = true,
				view = "cmdline_popup", --cmdline/cmdline_popup
				format = {
					cmdline = { pattern = "^:", icon = "󰅂", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					input = { pattern = "'<,'>s/", icon = "󰬲", title = "" },
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "lines;",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "change;",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					view = "split",
					filter = { event = "msg_show", min_height = 20 },
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			messages = {
				view_search = false,
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
			},
		},
	},

	--nvim-notify
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			fps = 50,
			background_colour = "#182912",
			timeout = 4000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.45)
			end,
			-- minimum_width = 30,
			render = "wrapped-compact",
			stages = "fade_in_slide_out",
			top_down = false,
			icons = {
				DEBUG = " ",
				ERROR = "󱙝 ",
				INFO = " ",
				TRACE = " ",
				WARN = "",
			},
		},
	},
}
