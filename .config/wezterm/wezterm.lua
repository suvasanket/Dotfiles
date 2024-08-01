require("core.helper")
local keys = require("core.keys")
local options = require("core.options")

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})

	window:gui_window():maximize()
	-- session_manager.restore_state(window:gui_window())
end)

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

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S")
	local workspace = window:active_workspace()

	window:set_right_status(wezterm.format({
		{ Text = workspace .. " " },
	}))
end)

wezterm.on("save_and_quit", function(window, pane)
	session_manager.save_state(window)
	window:perform_action(wezterm.action.QuitApplication, pane)
end)

config = {
	leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
	key_tables = {},
}

-- keys
add_config(keys)

-- options
add_config(options)

return config
