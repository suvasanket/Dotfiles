wezterm = require("wezterm")
config = wezterm.config_builder()
act = wezterm.action
mux = wezterm.mux
session_manager = require("wezterm-session-manager/session-manager")
workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

function add_config(mod, opt)
	if not opt then
		opt = config
	end
	for k, v in pairs(mod) do
		opt[k] = v
	end
end

