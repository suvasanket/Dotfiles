return {
	"nvim-lualine/lualine.nvim",
	event = "FileType",
	pin = true,
	config = function()
		local thyme = require("lualine.themes.codedark")
		local colors = {
			inactive = "#B0A695",
			color1 = "#80a0ff",
			color2 = "#D4ADFC",
			color4 = "#080808",
			color5 = "#DFCCFB",
			color6 = "#ff5189",
			color7 = "#FFE382",
			color8 = "#A8A196",
			bg = "#2B2B2B",
			abg = "#6D5D6E",
			bbg = "#4F4557",
		}
		thyme = {
			normal = {
				a = { fg = colors.color2, bg = colors.abg, gui = "bold" },
				b = { fg = colors.color5, bg = colors.bbg },
				c = { fg = colors.color8, bg = colors.bg },
			},
			insert = {
				a = { fg = colors.color7, bg = colors.abg, gui = "bold" },
				b = { fg = colors.color5, bg = colors.bbg },
				c = { fg = colors.color8, bg = colors.bg },
			},
			visual = {
				a = { fg = colors.color6, bg = colors.abg, gui = "bold" },
				b = { fg = colors.color5, bg = colors.bbg },
				c = { fg = colors.color8, bg = colors.bg },
			},
			replace = {
				a = { fg = colors.color1, bg = colors.abg, gui = "bold" },
				b = { fg = colors.color5, bg = colors.bbg },
				c = { fg = colors.color8, bg = colors.bg },
			},
			inactive = {
				a = { fg = colors.inactive, bg = colors.abg, gui = "bold" },
				b = { fg = colors.inactive, bg = colors.bbg },
				c = { fg = colors.color8, bg = colors.bg },
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = thyme,
				component_separators = { left = "", right = "" },
				section_separators = { left = " ", right = " " },
				disabled_filetypes = {
					statusline = { "alpha", "minintro" },
					winbar = { "alpha" },
				},
				globalstatus = false,
				ignore_focus = {},
				refresh = { statusline = 100 },
				-- fmt = string.lower,
			},

			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 3)
						end,
					},
				},
				lualine_b = {
					{
						"filename",
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = "󰳻",
							readonly = "",
							unnamed = "[No Name]",
							newfile = "󰎔",
						},
					},
				},
				lualine_c = {
					{
						"branch",
						icon = "",
					},
				},
				lualine_x = {
					{
						function()
							local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
							local searchCurrent = search.current
							local searchTotal = search.total
							if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
								return vim.fn.getreg("/") .. " [" .. searchCurrent .. "/" .. searchTotal .. "]"
							else
								return ""
							end
						end,
						color = "IncSearch", -- Highlight groups can also be used.
					},
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " " },
					},
				},
				lualine_y = {
					{
						"filetype",
						icon = false,
					},
				},
				lualine_z = {
					-- Lsp server name .
					{
						function()
							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
							local clients = vim.lsp.get_active_clients()
							if next(clients) == nil then
								return " "
							end
							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
									return "󱄙  " .. client.name
								end
							end
							return "󰚦 [no lsp]"
						end,
					},
				},
			},
			inactive_sections = {
				lualine_a = {
					{
						"filename",
						path = 0,
						shorting_target = 40,
						symbols = {
							modified = "󰳻",
							readonly = "",
							unnamed = "[No Name]",
							newfile = "󰎔",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			-- inactive_winbar = { lualine_z = { "filename" } },
			tabline = {
				lualine_a = { {
					"tabs",
					mode = 1,
					use_mode_colors = true,
				} },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {
				"telescope",
				"noice",
				"symbols-outline",
				"neo-tree",
				"fugitive",
				"neogit",
				"neogit-popup",
				"lazy",
				"Trouble",
				"nvim-dap-ui",
				"oil",
			},
		})
	end,
}
