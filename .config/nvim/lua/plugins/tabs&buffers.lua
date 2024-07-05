return {
	{
		"nanozuki/tabby.nvim",
		event = "VimEnter",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{
				"tiagovla/scope.nvim",
				opts = {},
			},
		},
		config = function()
			local theme = {
				current = { fg = "#BACD92", bg = "#303030", style = "bold" },
				not_current = { fg = "#a3a3a3", bg = "#303030" },

				fill = { bg = "#303030" },
			}

			require("tabby.tabline").set(function(line)
				return {
					line.tabs().foreach(function(tab)
						local hl = tab.is_current() and theme.current or theme.not_current
						return {
							line.sep(" ", hl, theme.fill),
							tab.name(),
							line.sep(" ", hl, theme.fill),
							hl = hl,
						}
					end),
					hl = theme.fill,
				}
			end)
		end,
	},
}
