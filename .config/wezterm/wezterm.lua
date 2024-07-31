local wezterm = require("wezterm")
local c = wezterm.config_builder()
local act = wezterm.action
local session_manager = require("wezterm-session-manager/session-manager")

wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

return {
	-- Color scheme and background color
	color_scheme = "fleet",
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
	line_height = 1.15,
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

	-- Key mapping
	leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		-- cmd + s
		{
			key = "s",
			mods = "CMD",
			action = wezterm.action({ SendKey = { key = "F1" } }),
		},
		-- cmd + w
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action_callback(function(window, pane)
				local process_name = pane:get_foreground_process_name()
				if process_name and process_name:match("vim") then
					window:perform_action(wezterm.action.SendKey({ key = "\\", mods = "CTRL|SHIFT" }), pane)
				else
					window:perform_action(wezterm.action.CloseCurrentPane({ confirm = false }), pane)
				end
			end),
		},
		{ key = "p", mods = "CMD|CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "n", mods = "CMD|CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },

		{ key = "s", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) },
		{ key = "r", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) },
		{
			key = "n",
			mods = "CMD",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
		-- Switch to the default workspace
		{ key = "]", mods = "CMD", action = act.SwitchWorkspaceRelative(1) },
		{ key = "[", mods = "CMD", action = act.SwitchWorkspaceRelative(-1) },
		{
			key = "a",
			mods = "CTRL|SHIFT",
			action = act.SwitchToWorkspace({
				name = "default",
			}),
		},
		-- Switch to a monitoring workspace, which will have `top` launched into it
		{
			key = "u",
			mods = "CTRL|SHIFT",
			action = act.SwitchToWorkspace({
				name = "monitoring",
				spawn = {
					args = { "top" },
				},
			}),
		},
		{ key = "i", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace },
		{
			key = "s",
			mods = "CTRL|CMD",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|WORKSPACES",
			}),
		},

		-- clear terminal
		{
			key = "k",
			mods = "CMD",
			action = act.Multiple({
				act.ClearScrollback("ScrollbackAndViewport"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},

		-- backspace
		{
			key = "Backspace",
			mods = "CMD",
			action = wezterm.action({ SendKey = { key = "u", mods = "CTRL" } }),
		},
		{
			key = "Backspace",
			mods = "ALT",
			action = wezterm.action({ SendKey = { key = "w", mods = "CTRL" } }),
		},
	},

	key_tables = {},
}
