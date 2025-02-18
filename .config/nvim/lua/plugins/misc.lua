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

	-- fidget
	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = { "LspAttach", "VeryLazy" },
		opts = {
			notification = {
				override_vim_notify = true, -- Automatically override vim.notify() with Fidget
				-- window = {
				-- 	winblend = 0,
				-- },
			},
		},
	},
}
