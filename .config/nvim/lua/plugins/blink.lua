return {
	{
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		version = "*",
		opts = {
			keymap = {
				preset = "none",
				["<C-k>"] = { "show", "hide" },
				["<C-l>"] = { "select_and_accept" },
				["<C-CR>"] = { "show_documentation", "hide_documentation" },

				["<C-p>"] = { "select_prev" },
				["<C-n>"] = { "select_next" },

				["<S-Up>"] = { "scroll_documentation_up", "fallback" },
				["<S-Down>"] = { "scroll_documentation_down", "fallback" },

				["<C-f>"] = { "snippet_forward", "fallback" },
				["<C-b>"] = { "snippet_backward", "fallback" },
				["<C-e>"] = {},
			},

			signature = { enabled = true },
            cmdline = { enabled = false },
			sources = {
                min_keyword_length = 5
			},
		},
	},
}
