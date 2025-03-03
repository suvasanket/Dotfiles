return {
	{
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		version = "*",
		dependencies = {
			{
				"chrisgrieser/nvim-scissors",
				keys = {
					{
						"<C-space>se",
						function()
							require("scissors").editSnippet()
						end,
						desc = "create Snippet",
					},
					{
						"<C-space>sc",
						function()
							require("scissors").addNewSnippet()
						end,
						mode = { "n", "x" },
						desc = "create Snippet",
					},
				},
				opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets" },
			},
		},
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "hide" },
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
			sources = {
				providers = {
					cmdline = {
						enabled = false,
					},
				},
			},
		},
	},
}
