return {
	"Shatur/neovim-session-manager",
	cmd = {
		"SessionManager",
	},
	keys = {
		{ "<leader>ql", "<cmd>SessionManager load_last_session<cr>", desc = "last session" },
		{ "<leader>qs", "<cmd>SessionManager<cr>", desc = "SessionManager" },
		{ "<leader>qd", "<cmd>SessionManager delete_session<cr>", desc = "delete session" },
	},
	event = { "QuitPre" },
	config = function()
		local config = require("session_manager.config")
		require("session_manager").setup({
			root_dir = "~/.dev/session/",
			autoload_mode = config.AutoloadMode.Disabled,
			autosave_last_session = true,
			autosave_ignore_not_normal = true,
		})
	end,
}
