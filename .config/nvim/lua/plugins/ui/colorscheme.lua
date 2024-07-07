return {
	{
		"navarasu/onedark.nvim",
		enabled = false,
		config = function()
			require("onedark").setup({
				style = "warmer",
				transparent = true,
				diagnostics = {
					darker = false, -- darker colors for diagnostic
				},
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "bold",
					strings = "none",
					variables = "none",
				},
				highlights = {
					PmenuSel = { bg = "#282C34", fg = "NONE" },
					Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

					CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE" },
					CmpItemAbbrMatch = { fg = "#A5F1E9", bg = "NONE", fmt = "bold" },
					CmpItemAbbrMatchFuzzy = { fg = "#A5F1E9", bg = "NONE", fmt = "bold" },

					TelescopeBorder = { fg = "#303030" , bg = "#303030" }
				},
			})
			require("onedark").load()
		end,
	},
	{
		"0xhoussam/fleet.nvim",
		config = function()
			vim.cmd("colorscheme fleet")
		end
	}
}
