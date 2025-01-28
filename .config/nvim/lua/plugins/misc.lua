return {
	{
		"Wansmer/treesj",
		keys = { { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Split/Join" } },
		opts = {
			use_default_keymaps = false,
			max_join_length = 220,
			notify = false,
		},
	},

	{ "romainl/vim-cool", event = { "BufReadPost" } },
	-- { "tpope/vim-sleuth", event = "BufRead" },
	{
		"kazhala/close-buffers.nvim",
		cmd = "BDelete",
		keys = {
			{
				"z0",
				function()
					vim.cmd([[BDelete hidden]])
					Notify("Hidden buffer removed")
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
			{ "<C-p>", "<cmd>YankBank<cr>", mode = { "n", "x" } },
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

	-- hl undo
	{
		"tzachar/highlight-undo.nvim",
		keys = { { "u" }, { "<C-r>" }, { "p" }, { "P" } },
		opts = {
			duration = 500,
		},
	},

	-- fidget --
	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = { "LspAttach", "BufReadPost" },
		opts = {
			notification = {
				override_vim_notify = false, -- Automatically override vim.notify() with Fidget
				window = {
					winblend = 0,
				},
			},
		},
	},
}
