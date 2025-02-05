return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{ "zx", "<cmd>lua Snacks.bufdelete()<cr>", desc = "bdel" },
		{ "zc", "<cmd>lua Snacks.picker('buffers')<cr>", desc = "hl" },
		{
			"<C-S-\\>",
			function()
				Snacks.picker({ layout = { preset = "vscode", preview = false } })
			end,
			desc = "picker",
		},
		{ "<leader>sh", "<cmd>lua Snacks.picker('help')<cr>", desc = "help" },
		{ "<leader>sk", "<cmd>lua Snacks.picker('keymaps')<cr>", desc = "keymaps" },
		{ "<leader>sl", "<cmd>lua Snacks.picker('highlights')<cr>", desc = "hl" },
		{
			"<leader>fp",
			function()
				Snacks.picker.files({ cwd = "~/.config", title = "Config" })
			end,
		},
		{
			"<C-f>",
			function()
				local root = GetProjectRoot()
				Snacks.picker.smart({
					cwd = root,
					title = vim.fs.basename(root) .. "/",
					layout = { preset = "ivy" },
					supports_live = true,
				})
			end,
		},
		{
			"<C-'>",
			function()
				Snacks.picker.grep({ cwd = GetProjectRoot() })
			end,
		},
		{ "gr", "<cmd>lua Snacks.picker('lsp_references')<cr>" },
		{
			"<leader>cd",
			function()
				Snacks.picker.diagnostics({
                    on_show = function() vim.cmd.stopinsert() end,
					layout = { preset = "ivy", preview = "main" },
				})
			end,
		},
	},
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		notifier = { style = "compact" },
		picker = {
			prompt = "> ",
			sources = {
				grep = { layout = { preset = "ivy", preview = "main" } },
				lsp_references = {
                    on_show = function() vim.cmd.stopinsert() end,
                    layout = { preset = "ivy_split" },
                },
				undo = {
					on_show = function()
						vim.cmd.stopinsert()
					end,
					layout = { preset = "sidebar" },
				},
			},
			win = {
				input = {
					keys = {
						["<C-u>"] = { "<c-u>", mode = { "i" }, expr = true },
						["<C-t>"] = { "edit_tab", mode = { "i" } },
						["<C-CR>"] = { "select_all", mode = { "i" } },
					},
				},
			},
		},
	},
}
