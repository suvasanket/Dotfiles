return {
	-- Color scheme and background color
	colors = {
		background = "#181818",
		tab_bar = {
			background = "#292929",
			active_tab = {
				bg_color = "#181818",
				fg_color = "#c0c0c0",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = "#292929",
				fg_color = "#808080",
			},
			-- new_tab = {
			-- 	bg_color = '#1b1032',
			-- 	fg_color = '#808080',
			-- },
		},
	},

	-- Fonts and font settings
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font Mono", weight = "DemiBold" },
		{ family = "FiraCode Nerd Font Mono" },
	}),
	font_size = 17.0,
	line_height = 1.2,
	use_cap_height_to_scale_fallback_fonts = true,

	-- Window and tab settings
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	window_decorations = "RESIZE",
	window_padding = {
		left = 50,
		right = 50,
		top = 50,
		bottom = 0,
	},

	-- cursor
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 500,

	-- command pallete
	command_palette_font_size = 16.0,

	-- confirm quit
	window_close_confirmation = 'NeverPrompt',

	default_workspace = "default",
}
