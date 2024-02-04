return {
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = {
			scroll = { enable = false },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPost",
		config = function()
			require("ufo").setup({
				close_fold_kinds = { "imports", "comment" },
				enable_get_fold_virt_text = true,

				---@diagnostic disable-next-line: unused-local
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{
		"tzachar/highlight-undo.nvim",
		keys = {
			{ "u" },
			{ "<C-r>" },
		},
		opts = {
			duration = 2000,
		},
	},
	{
		"nvimdev/hlsearch.nvim",
		event = "BufRead",
		config = function()
			require("hlsearch").setup()
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		event = "LspAttach",
		opts = {},
	},
}
