return {
	--og
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			dark_variant = "moon",
			disable_background = true,
			disable_float_background = true,

			groups = {
				border = "subtle",
				comment = "muted",
			},

			highlight_groups = {
				TelescopeBorder = { fg = "subtle", bold = true },
				PmenuSel = { fg = "pine", bg = "muted", blend = 3, bold = true },
				FloatBorder = { fg = "iris" },
				ColorColumn = { bg = "rose" },
				-- CursorLine = { bg = "muted", blend = 10 },
				StatusLine = { fg = "love", bg = "NONE", blend = 10 },
				Search = { bg = "gold", inherit = true },
				MiniIndentscopeSymbol = { fg = "pine" },
				MiniIndentscopeSymbolOff = { fg = "pine", bold = true },
				CursorLineNr = { fg = "iris" },
				CmpItemMenu = {  fg = "subtle", italic = true },
				CmpItemAbbr = { fg = "text" },
				CmpItemAbbrMatch = { fg = "foam" },
				CmpItemAbbrMatchFuzzy = { fg = "foam" },
				CmpItemKindVariable = { fg = "iris" },
				GitSignsAdd = { bg = "none" },
				GitSignsChange = { bg = "none" },
				GitSignsDelete = { bg = "none" },
				NeogitFold = { fg = "muted" },
			},
		},
	},
}
