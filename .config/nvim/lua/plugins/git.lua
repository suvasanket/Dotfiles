return {
	--gitsigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>g0", "<cmd>Gitsigns reset_buffer<cr>", desc = "git reset buffer" },
			{ "<leader>ga", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "git blame" },
			{
				"<leader>gs",
				"<cmd>Gitsigns stage_hunk<cr>",
				mode = { "v", "n" },
				desc = "git stage hunk",
			},
			{
				"<leader>gu",
				"<cmd>Gitsigns reset_hunk<cr>",
				mode = { "v", "n" },
				desc = "git reset hunk",
			},
		},
		opts = {
			signs = {
				-- add = { text = " ▍" },
				-- change = { text = " ▍" },
				-- delete = { text = "▁" },
				-- topdelete = { text = "🭶" },
				-- changedelete = { text = "~" },
				untracked = { text = "│" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
		},
	},

	--git
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gg", "<cmd>Git<cr>" },
		},
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"sindrets/diffview.nvim",
				keys = {
					{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "git diff/hist" },
					{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "git diff/hist close" },
				},
			},
		},
		opts = {}
	},
}
