return {
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

		{ key = "q", mods = "CMD", action = wezterm.action({ EmitEvent = "save_and_quit" }) },

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
			action = workspace_switcher.switch_workspace(),
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

		{ key = "P", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },
		{ key = "p", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },
	},
}
