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
					{ "<leader>cse", function() require("scissors").editSnippet() end, desc = "create Snippet" },
					{ "<leader>csa", function() require("scissors").addNewSnippet() end, mode = { "n", "x" }, desc = "create Snippet" },
				},
				opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets" },
			},
		},
		opts = {
			keymap = {
				show = "<tab>",
				hide = "<C-e>",
				accept = "<C-l>",
				select_next = "<C-n>",
				select_prev = "<C-p>",

				show_documentation = {},
				hide_documentation = {},
				scroll_documentation_up = "<S-Up>",
				scroll_documentation_down = "<S-Down>",

				snippet_forward = "<C-f>",
				snippet_backward = "<C-b>",
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
					{ 'blink.cmp.sources.path', name = 'Path', score_offset = 3 },
					{ 'blink.cmp.sources.snippets', name = 'Snippets', score_offset = 2 },
					{ 'blink.cmp.sources.lsp', name = 'LSP' },
					{ 'blink.cmp.sources.buffer', name = 'Buffer', fallback_for = { 'LSP' } },
				},
			},

			window = {
				autocomplete = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Cursorline:None",
					-- winblend = 7
				},
				documentation = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
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
				accept_key = "<C-a>",
				reject_key = "<Esc>",
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
