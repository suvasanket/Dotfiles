return {
	"nanozuki/tabby.nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local theme = {
			current = { fg = "#BACD92", bg = "transparent", style = "bold" },
			not_current = { fg = "#a3a3a3", bg = "transparent" },

			fill = { bg = "transparent" },
		}

		require("tabby.tabline").set(function(line)
			return {
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current or theme.not_current
					return {
						line.sep(" ", hl, theme.fill),
						tab.number(),
						line.sep(":", hl, theme.current),
						tab.name(),
						line.sep(" ", hl, theme.fill),
						hl = hl,
					}
				end),
				hl = theme.fill,
			}
		end)
	end,
}
