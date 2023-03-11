return {
	--Indent_BlankLine
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
	},

	--Alpha
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			require("alpha.themes.dashboard").section.footer.val = require("alpha.fortune")()
			require("alpha").setup(require("alpha.themes.startify").opts)
		end,
	},

	--scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "BufRead",
		opts = {
			excluded_buftypes = {
				"terminal",
				"Alpha",
			},
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"alpha",
				"NvimTree",
			},
			handlers = {
				cursor = false,
				diagnostic = true,
				gitsigns = false,
				handle = true,
				search = false,
				ale = true,
			},
		},
	},

	--Transparent
	{
		"xiyaowong/nvim-transparent",
		event = "BufEnter",
		opts = {
			enable = true,
			extra_groups = {
				"TelescopeNormal",
				"TelescopeBorder",
				"DiagnosticVirtualTextError",
				"DiagnosticVirtualTextWarn",
				"DiagnosticVirtualTextInfo",
				"DiagnosticVirtualTextHint",
				"NvimTreeNormal",
				"NvimTreeWinSeparator",
				"NvimTreeWinSeparator",
				"NvimTreeOpenedFolderIcon",
				"NoicePopup",
				"NotifyERRORBorder",
				"NotifyWARNBorder",
				"NotifyINFOBorder",
				"NotifyDEBUGBorder",
				"NotifyTRACEBorder",
				"NotifyWARNBody",
				"NotifyINFOBody",
				"NotifyDEBUGBody",
				"NotifyTRACEBody",
				"helpCommand",
				"MiniJump",
			},
		},
	},
}
