return {
	{
		"navarasu/onedark.nvim",
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

					CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
					CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
					CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
				},
			})
			require("onedark").load()
		end,
	},
}
