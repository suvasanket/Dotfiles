return {
	-- cmp alternative
	{
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		version = "v0.*",
		dependencies = {
			{
				"chrisgrieser/nvim-scissors",
				keys = {
					{
						"<leader>cse",
						function()
							require("scissors").editSnippet()
						end,
						desc = "create Snippet",
					},
					{
						"<leader>csa",
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

			highlight = {
				use_nvim_cmp_as_default = true,
			},

			nerd_font_variant = "normal",
			trigger = {
				signature_help = { enabled = true },
			},

			accept = {
				create_undo_point = true,
				auto_brackets = {
					enabled = true,
					default_brackets = { "(", ")" },
				},
			},

			sources = {
				providers = {
					path = { name = "Path", module = "blink.cmp.sources.path", score_offset = 3 },
					snippets = { name = "Snippets", module = "blink.cmp.sources.snippets" },
					lsp = { name = "LSP", module = "blink.cmp.sources.lsp" },
					buffer = { name = "Buffer", module = "blink.cmp.sources.buffer", fallback_for = { "LSP" } },
				},
			},
		},
	},

	-- wilder for cmdline
	{
		"gelguy/wilder.nvim",
		event = { "CmdlineEnter" },
		config = function()
			local wilder = require("wilder")
			wilder.setup({
				modes = { ":", "/", "?" },
				next_key = "<tab>",
				previous_key = "<s-tab>",
			})

			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline(),
					wilder.cmdline_pipeline({
						fuzzy = 1,
						set_pcre2_pattern = 1,
					}),
					wilder.search_pipeline(),
					wilder.python_search_pipeline({
						pattern = "fuzzy",
					})
				),
			})

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer({
					highlighter = wilder.basic_highlighter(),
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
				})
			)
		end,
	},
}
