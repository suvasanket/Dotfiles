return {
	{ "romainl/vim-cool", keys = { "/", "n", "N", "?", "*" } },

	{
		"kazhala/close-buffers.nvim",
		cmd = "BDelete",
		keys = {
			{
				"z'",
				function()
					vim.cmd([[BDelete hidden]])
					Notify("Hidden buffer removed", nil, "cleanup")
				end,
				desc = "delete hidden",
			},
		},
	},

	-- yank hist
	{
		"ptdewey/yankbank-nvim",
		event = "TextYankPost",
		keys = {
			{ "<leader>p", "<cmd>YankBank<cr>", mode = { "n", "x" } },
			{ "d", mode = { "n", "x" } },
			{ "D", mode = { "n", "x" } },
			{ "c", mode = { "n", "x" } },
		},
		config = function()
			require("yankbank").setup({
				keymaps = {
					paste = "p",
					paste_back = "P",
				},
			})
		end,
	},

	-- fidget
	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = { "LspAttach" },
		opts = {
			notification = {
				override_vim_notify = false, -- Automatically override vim.notify() with Fidget
				-- window = {
				-- 	winblend = 0,
				-- },
			},
		},
	},

	-- buf
	{
		"ton/vim-bufsurf",
		event = { "BufWinEnter" },
		keys = {
			{ "<C-e>", "<cmd>BufSurfListAll<cr>" },
			{ "<C-q>", "<cmd>BufSurfClear<cr>" },
			{ "zh", "<cmd>BufSurfBack<cr>" },
			{ "zl", "<cmd>BufSurfForward<cr>" },
		},
	},

	-- some
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = { "BufReadPost" },
		config = function()
			require("notify").setup({
				render = "wrapped-compact",
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	},
}
