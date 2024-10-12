return {
	--gitsigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>g0", "<cmd>Gitsigns reset_buffer<cr>", desc = "git reset buffer" },
			-- { "<leader>ga", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "git blame" },
			{ "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", mode = { "v", "n" }, desc = "git stage hunk" },
			{ "<leader>gu", "<cmd>Gitsigns reset_hunk<cr>", mode = { "v", "n" }, desc = "git reset hunk" },
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "git preview hunk" },
			{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "git diff hunk" },
			{ "]g", "<cmd>Gitsigns next_hunk<cr>", desc = "next hunk" },
			{ "[g", "<cmd>Gitsigns prev_hunk<cr>", desc = "next hunk" },
		},
		opts = {
			signs = {
				add = { text = " ▍" },
				change = { text = " ▍" },
				delete = { text = " " },
				topdelete = { text = " " },
				changedelete = { text = " ▋" },
				untracked = { text = "│" },
			},
			signs_staged = {
				add = { text = " ▍" },
				change = { text = " ▍" },
				delete = { text = " " },
				topdelete = { text = " " },
				changedelete = { text = "║" },
				untracked = { text = "│" },
			},
			signcolumn = true,
		},
	},
	-- The one n only --
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{"<leader>gg", "<cmd>G<cr>", desc = "Great"}
		}
	},
}
