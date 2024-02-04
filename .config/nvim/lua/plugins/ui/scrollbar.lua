return {
	"petertriho/nvim-scrollbar",
	event = "BufRead",
	opts = {
		handle = {
			blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
			highlight = "Visual",
			show_in_active_only = true,
			hide_if_all_visible = true, -- Hides everything if all lines are visible
		},
		excluded_buftypes = {
			"terminal",
			"Alpha",
		},
		excluded_filetypes = {
			"prompt",
			"TelescopePrompt",
			"alpha",
			"neo-tree",
			"minifiles"
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
}
