return {
	-- cmp alternative
	{
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		version = "*",
		dependencies = {
			{
				"chrisgrieser/nvim-scissors",
				keys = {
					{
						"\\se",
						function()
							require("scissors").editSnippet()
						end,
						desc = "create Snippet",
					},
					{
						"\\sc",
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
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-l>"] = { "select_and_accept" },
				["<C-e>"] = { "hide" },

				["<C-p>"] = { "select_prev" },
				["<C-n>"] = { "select_next" },

				["<S-Up>"] = { "scroll_documentation_up", "fallback" },
				["<S-Down>"] = { "scroll_documentation_down", "fallback" },

				["<C-f>"] = { "snippet_forward", "fallback" },
				["<C-b>"] = { "snippet_backward", "fallback" },
			},

			signature = {
				enabled = true,
			},
			completion = {
				accept = {
					create_undo_point = true,
					auto_brackets = { enabled = true },
				},
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},
}
