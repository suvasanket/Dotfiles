return {
	{
		"echasnovski/mini.diff",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>gd", ":lua MiniDiff.toggle_overlay()<cr>" },
		},
		config = function()
			require("mini.diff").setup({
				view = {
					style = vim.go.number and "sign" or "number",
					signs = { add = "│", change = "│", delete = "│" },
					priority = 199,
				},
				mappings = {
					apply = "gh",
					reset = "g0",
					textobject = "gh",
					goto_first = "[H",
					goto_prev = "[h",
					goto_next = "]h",
					goto_last = "]H",
				},
			})
		end,
	},
	-- The one n only --
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gr", "Gw" },
		keys = {
			{ "<leader>g<space>", ":G " },
		},
	},
}
