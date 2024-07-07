return {
	"folke/trouble.nvim",
	event = "LspAttach",
	opts = {
		-- severity = vim.diagnostic.severity.ERROR, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
		padding = false, -- add an extra new line on top of the list
		auto_close = false,
		auto_open = false,
		indent_lines = false, -- add an indent guide below the fold icons
		icons = {
			error = "",
			warning = "",
			hint = "",
			information = "",
			other = "",
		},
		action_keys = {
			open_split = { "<c-s>" },
			-- toggle_fold = { "za", "<tab>" }, -- toggle fold of current file
		},
	},
}
