return {
	"folke/snacks.nvim",
	priority = 1000,
    -- enabled = false,
	lazy = false,
	keys = {
		{ "zx", "<cmd>lua Snacks.bufdelete()<cr>", desc = "bdel" },
		{ "<C-S-\\>", "<cmd>lua Snacks.picker()<cr>", desc = "picker" },
		{ "<leader>hh", "<cmd>lua Snacks.picker('help')<cr>", desc = "help" },
		{ "<leader>hk", "<cmd>lua Snacks.picker('keymaps')<cr>", desc = "keymaps" },
		{ "<leader>hl", "<cmd>lua Snacks.picker('highlights')<cr>", desc = "hl" },
		{ "zc", "<cmd>lua Snacks.picker('buffers')<cr>", desc = "hl" },
	},
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		notifier = { enabled = true },
		scope = { enabled = true },
		picker = { enabled = true },
	},
}
