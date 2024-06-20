return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	config = function()
		local colors = {
			yellow = "#FFFF80",
			cyan = "#79dac8",
			black = "#0F0F0F",
			white = "#c6c6c6",
			red = "#ff5189",
			green = "#BACD92",
			grey = "#303030",
		}

		local bubbles_theme = {
			normal = {
				a = { fg = colors.green, bg = colors.grey, gui = "bold" },
				b = { fg = colors.green, bg = colors.grey },
				c = { fg = colors.green, bg = colors.grey },
			},
			insert = {
				-- a = { fg = colors.grey, bg = colors.green, gui = "bold" },
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

			-- inactive = {
			-- 	a = { fg = colors.white },
			-- 	b = { fg = colors.white },
			-- 	c = { fg = colors.white },
			-- },
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
				component_separators = "|",
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
					{ "branch", icon = "󰊢", separator = "" },
					"%=",
				},
				lualine_c = {
					{ "filetype", icon_only = true, padding = { left = 1, right = 0 }, separator = "" },
					{ "filename", path = 3, padding = { left = 0, right = 0 } },
				},
				lualine_x = {
					{ "diagnostics", sections = { 'error' }, symbols = { error = " ", warn = " ", info = " ", hint = "󰛨 " } },
					lsp,
				},
				lualine_y = {
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
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
			inactive = {},
		})
	end,
}
