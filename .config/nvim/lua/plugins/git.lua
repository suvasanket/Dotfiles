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
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "󰔷" },
				untracked = { text = "│" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			"nvim-telescope/telescope.nvim", -- optional
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Git" },
		},
		opts = {
			console_timeout = 3000,
			disable_hint = true,
			signs = {
				hunk = { "", "" },
				item = { "", "" },
				section = { "", "" },
			},
			mappings = {
				commit_editor = {
					["x"] = "Close",
					["s"] = "Submit",
					["q"] = "Abort",
				},
				commit_editor_I = {
					["<C-s>"] = "Submit",
					["<C-q>"] = "Abort",
				},
			},
		},
	},
}
