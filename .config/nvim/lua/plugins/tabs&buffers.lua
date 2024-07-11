return {
	-- tabline
	{
		"nanozuki/tabby.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			local theme = {
				fill = "TabLineFill",
				-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
			}
			require("tabby").setup({
				line = function(line)
					return {
						{
							line.sep("", theme.head, theme.fill),
						},
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and theme.current_tab or theme.tab
							return {
								line.sep("", hl, theme.fill),
								-- tab.is_current() and "" or "",
								tab.name(),
								tab.close_btn(""),
								line.sep("", hl, theme.fill),
								hl = hl,
								margin = " ",
							}
						end),
						line.spacer(),
						hl = theme.fill,
					}
				end,
				-- option = {}, -- setup modules' option,
			})
		end,
	},
	-- close buffer
	{
		"kazhala/close-buffers.nvim",
		cmd = "BDelete",
	},
}
