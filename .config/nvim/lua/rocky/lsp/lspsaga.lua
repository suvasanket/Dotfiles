local lspsaga = require("lspsaga")
lspsaga.setup({
	ui = {
		theme = "round",
		title = true,
		border = "rounded",
		winblend = 25,
		expand = "",
		collapse = "",
		preview = " ",
		code_action = "",
		diagnostic = "🐞",
		incoming = " ",
		outgoing = " ",
		hover = " ",
		kind = {},
	},
	symbol_in_winbar = {
		enable = false,
	},
})
--- In lsp attach function
local map = vim.api.nvim_buf_set_keymap
map(0, "n", "<leader>rn", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })
map(0, "n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
map(0, "x", "<leader>ca", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true })
map(0, "n", "K", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
map(0, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", { silent = true, noremap = true })
map(0, "n", "g]", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
map(0, "n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
map(0, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
map(0, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
