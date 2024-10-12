require("core.helper")
return {
	"AckslD/nvim-neoclip.lua",
	event = { "BufRead" },
	keys = {
		{
			"<leader>p",
			cmd_tele("neoclip initial_mode=normal theme=ivy layout_config={height=15} border=false prompt_prefix="),
			desc = "clipboard",
			mode = { "n", "x" }
		},
	},
	config = function()
		require("neoclip").setup({
			content_spec_column = false,
			keys = {
				telescope = {
					i = {
						select = "<cr>",
						paste = "<c-p>",
						paste_behind = "<c-k>",
						replay = "<c-q>", -- replay a macro
						delete = "<c-d>", -- delete an entry
						edit = "<c-e>", -- edit an entry
						custom = {},
					},
					n = {
						select = "<cr>",
						--- It is possible to map to more than one key.
						paste = { 'p', '<cr>' },
						paste_behind = "P",
						replay = "@",
						delete = "d",
						edit = "e",
						custom = {},
					},
				},
			},
		})
	end,
}
