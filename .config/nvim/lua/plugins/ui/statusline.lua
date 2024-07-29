return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	config = function()
		local colors = {
			yellow = "#FFFF80",
			cyan = "#79dac8",
			black = "#0F0F0F",
			white = "#C8C6C6",
			red = "#ff5189",
			green = "#BACD92",
			grey = "#303030",
			grey_white = "#B4B4B3",
		}

		local personal_theme = {
			normal = {
				a = { fg = colors.grey_white, bg = colors.grey, gui = "bold" },
				b = { fg = colors.grey_white, bg = colors.grey },
				c = { fg = colors.grey_white, bg = colors.grey },
			},
			insert = {
				a = { fg = colors.grey, bg = colors.green, gui = "bold" },
				b = { fg = colors.grey, bg = colors.green },
				c = { fg = colors.grey, bg = colors.green },
			},
			command = {
				a = { fg = colors.grey, bg = colors.yellow, gui = "bold" },
				b = { fg = colors.grey, bg = colors.yellow },
				c = { fg = colors.grey, bg = colors.yellow },
			},
			visual = {
				a = { fg = colors.grey, bg = colors.cyan, gui = "bold" },
				b = { fg = colors.grey, bg = colors.cyan },
				c = { fg = colors.grey, bg = colors.cyan },
			},
			replace = {
				a = { fg = colors.black, bg = colors.red, gui = "bold" },
				b = { fg = colors.black, bg = colors.red },
				c = { fg = colors.black, bg = colors.red },
			},

		}
		local lsp = function()
			local bufnr = vim.api.nvim_get_current_buf()

			local clients = vim.lsp.buf_get_clients(bufnr)
			if next(clients) == nil then
				return ""
			end

			local c = {}
			for _, client in pairs(clients) do
				if client.name ~= "null-ls" then
					table.insert(c, client.name)
				end
			end
			return "󰅠 " .. table.concat(c, ",")
		end

		local telescope = {
			sections = { lualine_a = { function () return " Telescope" end } },
			filetypes = { "TelescopePrompt", "TelescopeResults" },
		}

		require("lualine").setup({
			options = {
				theme = personal_theme,
				component_separators = "|",
				globalstatus = true,
				section_separators = { left = "", right = "" },
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
					{ "filetype", icon_only = true, padding = { left = 1, right = 0 }, separator = "" },
					{
						"filename",
						path = 4,
						padding = { left = 0, right = 0 },
						symbols = {
							modified = "",
							readonly = "󰈡",
							unnamed = "[unnamed]",
							newfile = "󰎔",
						},
					},
					-- "%=",
				},
				lualine_c = {},
				lualine_x = {
					{
						"diagnostics",
						sections = { "error" },
						symbols = { error = "", warn = "", info = "", hint = "" },
					},
					lsp,
				},
				lualine_y = {
					{ "branch", icon = { "󰊢", color = { fg = "red" } }, separator = "" },
				},
				lualine_z = {
					{
						function()
							return "["
						end,
						separator = "",
						padding = { left = 1, right = 0 },
					},
					{ "location", separator = "", padding = { left = 0, right = 0 } },
					{
						function()
							return "]"
						end,
						separator = "",
						padding = { left = 0, right = 1 },
					},
				},
			},
			tabline = {},
			extensions = {
				"oil",
				"lazy",
				"trouble",
				"fugitive",
				telescope
			},
		})
	end,
}
