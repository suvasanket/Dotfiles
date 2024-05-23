return {
	"nvim-lualine/lualine.nvim",
	event = "FileType",
	config = function()
		local colors = {
			yellow = "#FFFF80",
			cyan = "#79dac8",
			black = "#080808",
			white = "#c6c6c6",
			red = "#ff5189",
			green = "#ACE1AF",
			grey = "#303030",
		}

		local bubbles_theme = {
			normal = {
				a = { fg = colors.black, bg = colors.green },
				b = { fg = colors.white, bg = colors.grey },
				c = { fg = colors.white },
			},

			insert = { a = { fg = colors.black, bg = colors.yellow } },
			visual = { a = { fg = colors.black, bg = colors.cyan } },
			replace = { a = { fg = colors.black, bg = colors.red } },

			inactive = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white },
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

		require("lualine").setup({
			options = {
				theme = bubbles_theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" } } },
				lualine_b = {
					{ "filetype", icon_only = true, padding = { left = 1, right = 0 } },
					{ "filename", path = 1, padding = { left = 0, right = 0 } },
				},
				lualine_c = {
					"%=",
				},
				lualine_x = {},
				lualine_y = {
					lsp,
					{ "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = "󰛨 " } },
				},
				lualine_z = {
					{
						"branch",
						icon = "󰊢",
						separator = { right = "" },
					},
				},
			},
			inactive_sections = {
				lualine_a = { { "filename", separator = { left = "" } } },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { { "location", separator = { right = "" } } },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
