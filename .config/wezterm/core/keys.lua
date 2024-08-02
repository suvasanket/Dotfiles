require("core.nvim_split")

local sendKey = function(mods, key)
	return act.SendKey({ key = key, mods = mods })
end

local function procces_based(proc, if_in, if_not, window, pane)
	local process_name = pane:get_foreground_process_name()
	if process_name and process_name:match(proc) then
		window:perform_action(if_in, pane)
	else
		window:perform_action(if_not, pane)
	end
end

my_keys = {
	-- cmd + s
	{
		key = "s",
		mods = "CMD",
		action = sendKey(nil, "F1"),
	},
	-- cmd + w
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			procces_based("vim", sendKey("CTRL|SHIFT", "\\"), act.CloseCurrentPane({ confirm = false }), window, pane)
		end),
	},
	{ key = "p", mods = "CMD|CTRL", action = act({ ActivateTabRelative = -1 }) },
	{ key = "n", mods = "CMD|CTRL", action = act({ ActivateTabRelative = 1 }) },

	{ key = "s", mods = "LEADER", action = act({ EmitEvent = "save_session" }) },
	{ key = "L", mods = "LEADER", action = act({ EmitEvent = "load_session" }) },
	{ key = "l", mods = "LEADER", action = act({ EmitEvent = "restore_session" }) },

	{ key = "q", mods = "CMD", action = act({ EmitEvent = "save_and_quit" }) },

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
		action = act({ SendKey = { key = "u", mods = "CTRL" } }),
	},
	{
		key = "Backspace",
		mods = "ALT",
		action = act({ SendKey = { key = "w", mods = "CTRL" } }),
	},

	{ key = "P", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },
	{ key = "p", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },

	-- splits
	{ key = "h", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
	{ key = "l", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
	{ key = "j", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
	{ key = "k", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
	{ key = "|", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "_", mods = "CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
}


return {
	keys = my_keys,
}
