---@diagnostic disable: undefined-global
return {
	--Lualine
	{
		"nvim-lualine/lualine.nvim",
		event = "UiEnter",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "solarized_light",
					component_separators = { left = " ", right = " " },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "alpha" },
						winbar = { "alpha" },
					},
					globalstatus = true,
					ignore_focus = {},
				},

				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = { "branch", "diff" },
					lualine_c = {
						"diagnostics",
					},
					lualine_x = {
						{
							"filetype",
							colored = true,
							icon_only = true,
							icon = { align = "left" },
						},
						"filename",
					},
					lualine_y = {
						"filesize",
						{
							function()
								local msg = "No Active Lsp"
								local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
								local clients = vim.lsp.get_active_clients()
								if next(clients) == nil then
									return msg
								end
								for _, client in ipairs(clients) do
									local filetypes = client.config.filetypes
									if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
										return client.name
									end
								end
								return msg
							end,
							icon = " ",
						},
					},
					lualine_z = { "encoding" },
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				inactive_winbar = {},
				extensions = { "nvim-tree", "fzf", "quickfix", "fugitive", "nvim-dap-ui" },
			})
		end,
	},

	--Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File manager",
						highlight = "Directory",
						separator = true,
						text_align = "left",
					},
				},
				diagnostics = "nvim_lsp",
				show_buffer_close_icons = false,
				custom_filter = function(buf_number)
					if vim.bo[buf_number].filetype ~= "fugitive" then
						return true
					end
					if vim.fn.bufname(buf_number) ~= "crunner" then
						return true
					end
					if vim.fn.bufname(buf_number) ~= "fugitive" then
						return true
					end
				end,
			},
		},
	},
}
